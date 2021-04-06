//
//  VerificationViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/05.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class VerificationViewController: UIViewController {
    
    private let textLogo = UIImageView().then {
        $0.image = UIImage(named: "Text Logo")
    }
    private let verificationLbl  = UILabel().then {
        $0.text = "인증코드"
        $0.textColor = .black
        $0.font = UIFont(name: "BMJUA", size: 30)
    }
    private let codeTxtField = UITextField().then {
        $0.placeholder = "인증코드 입력"
        $0.font = UIFont(name: "BMJUA", size: 20)
        $0.layer.cornerRadius = 25
        $0.layer.borderColor = UIColor.black.cgColor
    }
    private let nextBtn = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(textLogo)
        view.addSubview(verificationLbl)
        view.addSubview(codeTxtField)
        view.addSubview(nextBtn)
        
        constantraint()
    }
    
    private func constantraint() {
        textLogo.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/17)
            make.width.equalTo(150)
            make.height.equalTo(70)
        }
        verificationLbl.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(textLogo.snp.bottom).offset(100)
        }
        codeTxtField.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(verificationLbl.snp.bottom).offset(50)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(codeTxtField.snp.bottom).offset(100)
            make.leading.equalTo(55)
            make.trailing.equalTo(-55)
        }
    }
    

}
