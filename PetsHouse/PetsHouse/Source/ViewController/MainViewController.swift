//
//  MainViewController.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/12.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class MainViewController: UIViewController {
    
    private let logoView = UIImageView().then {
        $0.image = UIImage(named: "Logo with text")
    }
    private let sequencePicker = UITextField()
    private let areaPicker = UITextField()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

