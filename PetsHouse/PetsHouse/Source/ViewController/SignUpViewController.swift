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
    
    private let disposeBag = DisposeBag()
    private let viewModel = SignUpViewModel()
    
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
        $0.layer.cornerRadius = 15
    }
    private let signInBtn = UIButton().then {
        $0.clipsToBounds = true
        $0.setTitle("이미 계정이 있으신가요? 로그인 하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        passwordTxtField.isSecureTextEntry = true

        view.addSubview(logoView)
        view.addSubview(nicknameLbl)
        view.addSubview(nicknameTxtField)
        view.addSubview(emailLbl)
        view.addSubview(emailTxtField)
        view.addSubview(passwordLbl)
        view.addSubview(passwordTxtField)
        view.addSubview(signInBtn)
        view.addSubview(signUpBtn)
        
        constantraint()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = SignUpViewModel.Input(nickname: nicknameTxtField.rx.text.orEmpty.asDriver(),
                                          email: emailTxtField.rx.text.orEmpty.asDriver(),
                                          password: passwordTxtField.rx.text.orEmpty.asDriver(),
                                          doneTap: signUpBtn.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.isEnable.drive(signUpBtn.rx.isEnabled).disposed(by: disposeBag)
        output.result.emit(onNext: { _ in
            self.pushVC("verificationVC")
        }).disposed(by: disposeBag)
    }
    
    func setUI() {
        signUpBtn.rx.tap.subscribe(onNext: { _ in
            self.pushVC("verificationVC")
        }).disposed(by: disposeBag)
        
    }
    
    //Constantraint
    private func constantraint() {
        logoView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/5)
            make.width.height.equalTo(220)
        }
        nicknameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-50)
        }
        nicknameTxtField.snp.makeConstraints { (make) in
            make.top.equalTo(nicknameLbl.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        emailLbl.snp.makeConstraints { (make) in
            make.top.equalTo(nicknameTxtField.snp.bottom).offset(40)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-50)
        }
        emailTxtField.snp.makeConstraints { (make) in
            make.top.equalTo(emailLbl.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        passwordLbl.snp.makeConstraints{ (make) in
            make.top.equalTo(emailTxtField.snp.bottom).offset(40)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        passwordTxtField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLbl.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        signUpBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTxtField.snp.bottom).offset(50)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(40)
        }
        signInBtn.snp.makeConstraints { (make) in
            make.top.equalTo(signUpBtn.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }

    }
}
