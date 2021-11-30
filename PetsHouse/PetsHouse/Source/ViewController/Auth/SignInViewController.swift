//
//  SignInViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/03/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class SignInViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = SignInViewModel()
    
    //UI
    private let titleLabel = UILabel().then {
        $0.text = "이메일과 비밀번호를\n입력하여\n로그인하세요!"
        $0.textColor = .black
        $0.font = UIFont(name: "BMJUA", size: 20)
        $0.numberOfLines = 0
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
    private let emailView = UIView().then {
        $0.backgroundColor = .textFieldBack
        $0.layer.cornerRadius = 5
    }
    private let emailTxtField = UITextField().then {
        $0.placeholder = "email"
        $0.font = UIFont(name: "BMJUA", size: 15)
        $0.autocapitalizationType = .none
        $0.keyboardType = .emailAddress
    }
    private let passwordView = UIView().then {
        $0.backgroundColor = .textFieldBack
        $0.layer.cornerRadius = 5
    }
    private let passwordTxtField = UITextField().then {
        $0.placeholder = "password"
        $0.font = UIFont(name: "BMJUA", size: 15)
    }
    private let signInBtn = UIButton().then {
        $0.backgroundColor = .appGray
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
    }
    private let signUpBtn = UIButton().then {
        $0.setTitle("계정이 없으신가요? 회원가입 하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "BMJUA", size: 12)
    }
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        titleLabel.setLineSpacing(lineSpacing: 7.0)

        constraint()
        bindViewModel()
        setUI()
    }
    
    func bindViewModel() {
        let input = SignInViewModel.Input(email: emailTxtField.rx.text.orEmpty.asDriver(),
                                          password: passwordTxtField.rx.text.orEmpty.asDriver(),
                                          doneTap: signInBtn.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.isEnable.drive(signInBtn.rx.isEnabled).disposed(by: disposeBag)
        output.result.emit(onCompleted: { [unowned self] in
            self.pushVC("mainVC")
        }).disposed(by: disposeBag)
    }
    
    func setUI() {
        signUpBtn.rx.tap.subscribe(onNext: { _ in
            self.pushVC("signUpVC")
        }).disposed(by: disposeBag)
        
        passwordTxtField.isSecureTextEntry = true
    }

    //Constantraint
    func constraint() {
        view.do {
            $0.addSubview(titleLabel)
            $0.addSubview(emailLbl)
            $0.addSubview(emailView)
            emailView.addSubview(emailTxtField)
            $0.addSubview(passwordLbl)
            $0.addSubview(passwordView)
            passwordView.addSubview(passwordTxtField)
            $0.addSubview(signInBtn)
            $0.addSubview(signUpBtn)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalTo(20)
        }

        emailLbl.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(20)
        }
        emailView.snp.makeConstraints { make in
            make.top.equalTo(emailLbl.snp.bottom).offset(13)
            make.centerX.equalTo(view)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
        }
        emailTxtField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        passwordLbl.snp.makeConstraints{ (make) in
            make.top.equalTo(emailTxtField.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.leading.equalTo(20)
        }
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(passwordLbl.snp.bottom).offset(13)
            make.centerX.equalTo(view)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(40)
        }
        passwordTxtField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        signInBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(45)
        }
        signUpBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTxtField.snp.bottom).offset(10
            )
            make.trailing.equalTo(-30)
        }

    }
}
