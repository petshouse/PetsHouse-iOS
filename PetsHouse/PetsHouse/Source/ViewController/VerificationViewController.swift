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
    private let VerificationLbl  = UILabel().then {
        $0.text = "인증코드"
        $0.textColor = .black
        $0.font = UIFont(name: "BMJUA", size: 30)
    }
    private let codeTxtField = UITextField().then {
        $0.placeholder = "인증코드 입력"
        $0.font = UIFont(name: "BMJUA", size: 20)
        $0.layer.cornerRadius = 25
        $0.layer.borderColor = .init(red: 051, green: 051, blue: 051, alpha: 1)
    }
    private let nextBtn = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
