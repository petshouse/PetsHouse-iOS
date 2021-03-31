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
    
    private let userImage = UIImageView().then {
        $0.clipsToBounds = true
    }
    private let titleLbl = UILabel()
    
    private let writeTxtView = UITextView()
    private let animalImage = UIImageView()
    private let photoImage = UIImageView().then {
        $0.image = UIImage(named: "library")
    }
    private let photoLbl = UILabel().then {
        $0.text = "사진 선택하기"
        $0.font = UIFont(name: "BMJUA", size: 20)
        $0.textColor = .black
    }
    private let cameraBtn = UIButton().then {
        $0.clipsToBounds = true
        $0.imageView?.backgroundColor = .white
        $0.setImage(UIImage(named: "Main_Logo"), for: UIControl.State.normal)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
}
