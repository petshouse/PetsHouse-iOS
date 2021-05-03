//
//  FirstViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/05/03.
//

import UIKit

class FirstViewController: UIViewController {
    
    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "Logo with Text")
    }
    private let signInBtn = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
    }
    private let signUpBtn = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(logoImage)
        view.addSubview(signInBtn)
        view.addSubview(signUpBtn)
    }
    
    private func constantraint() {
        logoImage.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(100)
            make.height.equalTo(283)
            make.width.equalTo(266)
        }
        signInBtn.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(logoImage.snp.bottom).offset(40)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(45)
        }
        signUpBtn.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(signInBtn.snp.bottom).offset(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(45)
        }
    }
    
    
    

}
