//
//  SendEmailViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/22.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class SendEmailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = SendEmailViewModel()
    
    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "Text Logo")
    }
    private let emailLbl = UILabel().then {
        $0.text = "이메일 입력"
        $0.textColor = .black
        $0.font = UIFont(name: "BMJUA", size: 30)
    }
    private let emailTxtField = UITextField().then {
        $0.placeholder = "인증코드를 받을 이메일을 입력해주세요"
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 15
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
        
        view.addSubview(logoImage)
        view.addSubview(emailLbl)
        view.addSubview(emailTxtField)
        view.addSubview(nextBtn)
        
        constantraint()
    }
    
    private func constantraint() {
        logoImage.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/15)
            make.width.equalTo(170)
            make.height.equalTo(70)
        }
        emailLbl.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(logoImage.snp.bottom).offset(130)
        }
        emailTxtField.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(emailLbl.snp.bottom).offset(80)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
            make.height.equalTo(50)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(emailTxtField.snp.bottom).offset(120)
            make.leading.equalTo(55)
            make.trailing.equalTo(-55)
            make.height.equalTo(40)
        }
    }

}
