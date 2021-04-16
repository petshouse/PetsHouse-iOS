//
//  WriteViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/03/29.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class WriteViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = WriteViewModel()
    
    private let editImageData = BehaviorRelay<Data?>(value: nil)

    private let userImage = UIImageView().then {
        $0.clipsToBounds = true
    }
    private let titleTxtField = UITextField()
    private let sequencePicker = UITextField()
    private let writeTxtView = UITextView()
    private let animalImage = UIImageView()
    private let photoImage = UIImageView().then {
        $0.image = UIImage(named: "library")
    }
    private let photoBtn = UIButton().then {
        $0.setTitle("사진 선택하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    private let cameraBtn = UIButton().then {
        $0.clipsToBounds = true
        $0.imageView?.backgroundColor = .white
        $0.setImage(UIImage(named: "Main_Logo"), for: UIControl.State.normal)
    }
    private let cameraLbl = UILabel().then {
        $0.text = "사진 촬영하기"
        $0.textColor = .black
        $0.font = UIFont(name: "BMJUA", size: 20)
    }
    private let postBtn = UIBarButtonItem()
    
    let pickerView = UIPickerView()
    let doneToolBar = UIToolbar()
    let doneBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil)
    
    var sequenceData: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        view.addSubview(userImage)
        view.addSubview(titleTxtField)
        view.addSubview(sequencePicker)
        view.addSubview(writeTxtView)
        view.addSubview(animalImage)
        view.addSubview(photoImage)
        view.addSubview(photoBtn)
        view.addSubview(cameraBtn)
        
        constantraint()
        bindViewModel()
        setUI()
        pickerBind()
        createPicker()
    }
    
    func bindViewModel() {
        let input = WriteViewModel.Input(titleText: titleTxtField.rx.text.orEmpty.asDriver(),
                                         postText: writeTxtView.rx.text.orEmpty.asDriver(),
                                         selectImage: editImageData.asDriver(onErrorJustReturn: nil),
                                         doneTap: postBtn.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.isEnable.drive(postBtn.rx.isEnabled).disposed(by: disposeBag)
        output.result.emit(onCompleted: { [unowned self] in
            navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    func setUI() {
        cameraBtn.rx.tap.subscribe(onNext: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        photoBtn.rx.tap.subscribe(onNext: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        doneBarButton.rx.tap.subscribe(onNext: { _ in
            let selectRow = self.pickerView.selectedRow(inComponent: 0)
            self.sequencePicker.text = self.sequenceData[selectRow]
            self.sequencePicker.resignFirstResponder()
        }).disposed(by: disposeBag)
        
    }
    
    func pickerBind() {
        pickerView.delegate = self
        pickerView.dataSource = nil
        sequencePicker.inputView = pickerView
        
        _ = Observable.just(sequenceData).bind(to: pickerView.rx.itemTitles) { _, item in
            return "\(item)"
        }
    }
    
    func createPicker() {
        doneToolBar.sizeToFit()
        doneToolBar.items = [doneBarButton]
        
        sequencePicker.inputAccessoryView = doneToolBar
        sequencePicker.inputView = pickerView
    }
    
    func constantraint() {
        userImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/2)
            make.leading.equalTo(30)
        }
        titleTxtField.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/2)
            make.leading.equalTo(userImage.snp.right).offset(10)
        }

        writeTxtView.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(titleTxtField.snp.bottom).offset(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        animalImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(writeTxtView.snp.bottom).offset(15)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        photoImage.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(animalImage.snp.bottom).offset(13)
            make.leading.equalTo(30)
        }
        photoBtn.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.leading.equalTo(photoImage.snp.right).offset(7)
            make.top.equalTo(animalImage.snp.bottom).offset(13)
        }
        cameraLbl.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.frame.height/2)
        }
        cameraBtn.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(cameraLbl.snp.top).offset(10)
        }
    }

}

extension WriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            animalImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

