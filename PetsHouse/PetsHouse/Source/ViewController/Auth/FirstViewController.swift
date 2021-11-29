//
//  FirstViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/05/03.
//

import UIKit

import RxSwift
import RxCocoa

class FirstViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let backImage = UIImageView().then {
        $0.image = UIImage(named: "First_back_Image")
    }
    
    private let bottomView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
    }
    
    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "Text Logo")
    }
    
    private let infoLabel = UILabel().then {
        $0.text = "최근 유기동물, 유실동물의 수는 해가 갈 수록\n증가하고 있습니다\n \n동물들이 따듯한 가족의 품으로 돌아갈 수 있도록\nPets House를 통해 도와주세요"
        $0.font = UIFont(name: "BMJUA", size: 16)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private let signInButton = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
    }
    private let signUpButton = UIButton().then {
        $0.setTitle("계정이 없으신가요? 회원가입 하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "BMJUA", size: 14)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backImage.alpha = 0.5
        navigationController?.isNavigationBarHidden = true
        
        constantraint()
        tapAction()
    }
    
    func tapAction() {
        signInButton.rx.tap.bind {
            self.pushVC("signInVC")
        }.disposed(by: disposeBag)
        
        signUpButton.rx.tap.bind {
            self.pushVC("signUpVC")
        }.disposed(by: disposeBag)
    }
    
    private func constantraint() {
        view.do {
            $0.addSubview(backImage)
            $0.addSubview(bottomView)
        }
        
        bottomView.do {
            $0.addSubview(logoImage)
            $0.addSubview(infoLabel)
            $0.addSubview(signInButton)
            $0.addSubview(signUpButton)
        }
        
        backImage.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(460)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(backImage.snp.bottom).offset(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(15)
            make.centerX.equalTo(bottomView)
            make.width.equalTo(180)
            make.height.equalTo(54)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(45)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(45)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(10)
            make.centerX.equalTo(bottomView)
        }
    }

}


