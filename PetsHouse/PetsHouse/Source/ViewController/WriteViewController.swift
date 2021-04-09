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

class WriteViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let userImage = UIImageView().then {
        $0.clipsToBounds = true
    }
    private let titleLbl = UILabel()
    private let dropDownBtn = UIButton().then {
        $0.setTitle("지역 선택", for: .normal)
    }
    private let locationDropDown = DropDown().then {
        $0.layer.borderColor = UIColor.black.cgColor
        $0.bottomOffset = CGPoint(x: 0, y:($0.anchorView?.plainView.bounds.height)!)
        $0.cornerRadius = 15
        $0.cellHeight = 30
        $0.selectionBackgroundColor = UIColor.white
        $0.show()
    }
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        view.addSubview(userImage)
        view.addSubview(titleLbl)
        view.addSubview(dropDownBtn)
        view.addSubview(locationDropDown)
        view.addSubview(writeTxtView)
        view.addSubview(animalImage)
        view.addSubview(photoImage)
        view.addSubview(photoBtn)
        view.addSubview(cameraBtn)
        
        constantraint()
    }
    
    func constantraint() {
        userImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/2)
            make.leading.equalTo(30)
        }
        titleLbl.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/2)
            make.leading.equalTo(userImage.snp.right).offset(10)
        }
        locationDropDown.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(userImage.snp.bottom).offset(20)
            make.width.equalTo(150)
        }
        writeTxtView.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(locationDropDown.snp.bottom).offset(20)
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
        
        
    }

}

extension WriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

