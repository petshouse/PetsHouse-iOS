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
import DropDown
import KMPlaceholderTextView

class WriteViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = WriteViewModel()
    
    private let editImageData = BehaviorRelay<Data?>(value: nil)

 
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var areaTxtField: UITextField!
    @IBOutlet weak var writeTxtView: KMPlaceholderTextView!
    @IBOutlet weak var libraryImage: UIImageView!
    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var cameraLbl: UILabel!
    @IBOutlet weak var postBtn: UIBarButtonItem!
    
    let areaDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        bindViewModel()
        setUI()
    }

    func bindViewModel() {
        let input = WriteViewModel.Input(titleText: titleTxtField.rx.text.orEmpty.asDriver(),
                                         postText: writeTxtView.rx.text.orEmpty.asDriver(),
                                         selectImage: editImageData.asDriver(onErrorJustReturn: nil),
                                         area: areaTxtField.rx.text.orEmpty.asDriver(),
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
        
        postBtn.rx.tap.subscribe(onNext: { _ in
            self.alert("성공", "등록되었습니다❗️")
        }).disposed(by: disposeBag)
        
        self.navigationController?.navigationBar.tintColor = .mainColor
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

