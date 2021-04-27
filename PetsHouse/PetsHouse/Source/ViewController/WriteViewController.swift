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
    @IBOutlet weak var areaPicker: UIPickerView!
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
        picker()
    }
    
    private func picker() {
        Observable.just(["서울", "대전", "광주", "대구", "부산", "울산", "제주", "강원", "경기", "전남","전북", "경남","경북","충남","충북"])
            .bind(to: areaPicker.rx.itemTitles) { _, item in
                return "\(item)"
            }.disposed(by: disposeBag)
        areaPicker.rx.itemSelected.subscribe(onNext: { (row, value) in
            NSLog("selected: \(row)")
            }).disposed(by: disposeBag)
        
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

