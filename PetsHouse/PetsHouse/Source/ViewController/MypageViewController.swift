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
    private let nameLbl = UILabel().then{
        $0.text = "name"
        $0.font = UIFont(name: "BMJUA", size: 30)
    }
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoView)
        view.addSubview(nameLbl)
        view.addSubview(tableView)
        
        constantraint()
    }
    
    private func setUI() {
        tableView.register(MainCell.self, forCellReuseIdentifier: "mainCell")
        tableView.rowHeight = 220
        
        tableView.delegate = self
        tableView.dataSource = nil
    }
    
    private func constantraint() {
        logoView.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/15)
            make.width.equalTo(170)
            make.height.equalTo(50)
        }
        nameLbl.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(logoView.snp.bottom).offset(25)
        }
        tableView.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(nameLbl.snp.bottom).offset(30)
        }
    }
}

extension MypageViewController: UITableViewDelegate{
    
}
