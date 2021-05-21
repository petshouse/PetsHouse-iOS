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
    private let nameLbl = UILabel().then {
        $0.text = "이름"
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
    private let nameTxtField = UITextField().then {
        $0.placeholder = "name"
        $0.font = UIFont(name: "BMJUA", size: 15)
    }
    private  let emailTxtField = UITextField().then {
        $0.placeholder = "email"
        $0.font = UIFont(name: "BMJUA", size: 15)
        $0.autocapitalizationType = .none
        $0.keyboardType = .emailAddress
    }
    private let checkBtn = UIButton().then {
        $0.setTitle("중복체크", for: .normal)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.titleLabel?.font = UIFont(name: "BMJUA", size: 15)
        $0.layer.borderColor = UIColor.mainColor.cgColor
        $0.layer.cornerRadius = 25
    }
    private let passwordTxtField = UITextField().then {
        $0.placeholder = "password"
        $0.font = UIFont(name: "BMJUA", size: 15)
        $0.textColor = .black
        $0.autocapitalizationType = .none
    }
    private let signUpBtn = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
    }
    private let signInBtn = UIButton().then {
        $0.setTitle("이미 계정이 있으신가요? 로그인 하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "BMJUA", size: 10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        passwordTxtField.isSecureTextEntry = true
        
        view.addSubview(logoView)
        view.addSubview(nameLbl)
        view.addSubview(nameTxtField)
        view.addSubview(emailLbl)
        view.addSubview(emailTxtField)
        view.addSubview(checkBtn)
        view.addSubview(passwordLbl)
        view.addSubview(passwordTxtField)
        view.addSubview(signInBtn)
        view.addSubview(signUpBtn)
        
        constantraint()
        bindViewModel()
        setUI()
    }
    
    func bindViewModel() {
        let input = SignUpViewModel.Input(nickname: nameTxtField.rx.text.orEmpty.asDriver(),
                                          email: emailTxtField.rx.text.orEmpty.asDriver(),
                                          password: passwordTxtField.rx.text.orEmpty.asDriver(),
                                          duplicateTap: checkBtn.rx.tap.asDriver(),
                                          doneTap: signUpBtn.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.isEnable.drive(signUpBtn.rx.isEnabled).disposed(by: disposeBag)
        
        output.duplicateCheck.emit(onNext: { [unowned self] error in
            self.alert("실패", error)
        }, onCompleted: {[unowned self] in
            self.alert("성공", "사용가능한 이메일")
        }).disposed(by: disposeBag)
        
        output.result.emit(onCompleted: {
            self.alert("성공", "인증코드 받으러 가기")
            self.pushVC("sendEmailVC")
        }).disposed(by: disposeBag)
    }
    
    func setUI() {
        signInBtn.rx.tap.subscribe(onNext: { _ in
            self.pushVC("signInVC")
        }).disposed(by: disposeBag)
        
        nameTxtField.underLine()
        emailTxtField.underLine()
        passwordTxtField.underLine()
    }
    
    //Constantraint
    private func constantraint() {
        logoView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/5)
            make.width.height.equalTo(220)
        }
        nameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-50)
        }
        nameTxtField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLbl.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        emailLbl.snp.makeConstraints { (make) in
            make.top.equalTo(nameTxtField.snp.bottom).offset(40)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-50)
        }
        emailTxtField.snp.makeConstraints { (make) in
            make.top.equalTo(emailLbl.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.leading.equalTo(30)
            make.trailing.equalTo(-100)
        }
        checkBtn.snp.makeConstraints{ (make) in
            make.top.equalTo(nameTxtField.snp.bottom).offset(70)
            make.leading.equalTo(emailTxtField.snp.trailing).offset(20)
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
