//
//  MypageViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/28.
//

import Foundation

import RxSwift
import RxCocoa
import SnapKit
import Then

class MypageViewController: UIViewController {
    
    private let logoView = UIImageView().then {
        $0.image = UIImage(named: "Text Logo")
    }
    private let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.frame.size.width/2 
        $0.image = UIImage(named: "Test Image")
    }
    private let nickNameLbl = UILabel().then{
        $0.text = "nickname"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoView)
        view.addSubview(profileImage)
        view.addSubview(nickNameLbl)
        
        constantraint()
    }
    
    private func constantraint() {
        logoView.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/15)
            make.width.equalTo(170)
            make.height.equalTo(70)
        }
        profileImage.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(logoView.snp.bottom).offset(20)
            make.leading.equalTo(30)
//            make.trailing.equalTo(nickNameLbl.snp.leading).offset(10)
            make.width.height.equalTo(150)
        }
        nickNameLbl.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(logoView.snp.bottom).offset(25)
            make.leading.equalTo(profileImage.snp.trailing).offset(15)
        }
    }
}
