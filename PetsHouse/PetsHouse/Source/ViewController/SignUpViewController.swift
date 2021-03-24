//
//  SignUpViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/03/23.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    //UI
    private let logoView = UIImageView().then {
        $0.image = UIImage(named: "Logo with text")
    }
    private let nicknameLbl = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = .black
        $0.font = UIFont(name: "BMJUA", size: 15)
    }
    private let emailLbl = UILabel().then {
        $0.text = "이메일"
        $0.textColor = .black
        $0.font = UIFont(name: "BMJUA", size: 15)
    }
    private let passwordLbl = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = .black
        $0.font = UIFont(name: "BMJUA", size: 15)
    }
    private let nicknameTxtField = UITextField().then {
        $0.placeholder = "nickname"
        $0.font = UIFont(name: "BMJUA", size: 25)
        $0.layer.cornerRadius = 25
        $0.layer.borderColor = .init(red: 051, green: 051, blue: 051, alpha: 1)
        $0.backgroundColor = .white
    }
    private  let emailTxtField = UITextField().then {
        $0.placeholder = "email"
        $0.font = UIFont(name: "BMJUA", size: 25)
        $0.layer.cornerRadius = 25
        $0.layer.borderColor = .init(red: 051, green: 051, blue: 051, alpha: 1)
        $0.backgroundColor = .white
    }
    private let checkBtn = UIButton().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.setTitle("중복체크", for: .normal)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.layer.borderColor = .init(red: 255, green: 204, blue: 153, alpha: 1)
        $0.layer.cornerRadius = 25
    }
    private let passwordTxtField = UITextField().then {
        $0.placeholder = "password"
        $0.font = UIFont(name: "BMJUA", size: 25)
        $0.layer.cornerRadius = 25
        $0.layer.borderColor = .init(red: 051, green: 051, blue: 051, alpha: 1)
        $0.backgroundColor = .white
    }
    private let signUpBtn = UIButton().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .mainColor
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 25
    }
    private let signInBtn = UIButton().then {
        $0.clipsToBounds = true
        $0.setTitle("이미 계정이 있으신가요? 로그인 하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
