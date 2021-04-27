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
    
    private let disposeBag = DisposeBag()
    private let viewModel = VertificationViewModel()
    
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
        $0.borderStyle = .roundedRect
    }
    private let nextBtn = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
    }
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(textLogo)
        view.addSubview(verificationLbl)
        view.addSubview(codeTxtField)
        view.addSubview(nextBtn)
        
        constantraint()
        bindViewModel()
    }
    
    private func bindViewModel() {
        nextBtn.rx.tap.asObservable().subscribe(onNext: { [unowned self] in
            let api = Service()
            api.verification(email, codeTxtField.text!).subscribe(onNext: { (response) in
                switch response {
                case .success:
                    pushData()
                case .forbidden:
                    print("올바르지 않은 코드")
                case .preconditionFailed:
                    print("preconditionFailed")
                default:
                    print("verification default")
                }
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
    }
    
    func pushData() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "inputUser") as? SignInViewController else { return }
        vc.email = email
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    private func constantraint() {
        textLogo.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/15)
            make.width.equalTo(170)
            make.height.equalTo(70)
        }
        verificationLbl.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(textLogo.snp.bottom).offset(130)
        }
        codeTxtField.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(verificationLbl.snp.bottom).offset(80)
            make.leading.equalTo(90)
            make.trailing.equalTo(-90)
            make.height.equalTo(50)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(codeTxtField.snp.bottom).offset(120)
            make.leading.equalTo(55)
            make.trailing.equalTo(-55)
            make.height.equalTo(40)
        }
    }
    

}
