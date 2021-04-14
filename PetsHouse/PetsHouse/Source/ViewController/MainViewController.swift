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
    
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()
    
    private let loadData = BehaviorRelay<Void>(value: ())
    
    private let logoView = UIImageView().then {
        $0.image = UIImage(named: "Logo with text")
    }
    private let sequencePicker = UITextField()
    private let areaPicker = UITextField()
    private let tableView = UITableView()
    
    let pickerView = UIPickerView()
    let doneToolBar = UIToolbar()
    let doneBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil)

    var sequenceData: [String] = []
    var areaData: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(logoView)
        view.addSubview(sequencePicker)
        view.addSubview(areaPicker)
        view.addSubview(tableView)
        
        setUI()
        pickerBind()
        createPicker()
        constantraint()
    }
    
    func setUI() {
        doneBarButton.rx.tap.subscribe(onNext: { _ in
            let selectRow = self.pickerView.selectedRow(inComponent: 0)
            self.sequencePicker.text = self.sequenceData[selectRow]
            self.sequencePicker.resignFirstResponder()
            self.areaPicker.text = self.areaData[selectRow]
            self.areaPicker.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        tableView.delegate = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.rowHeight = 60
    }
    
    func pickerBind() {
        pickerView.delegate = self
        pickerView.dataSource = nil
        sequencePicker.inputView = pickerView
        areaPicker.inputView = pickerView
        
        _ = Observable.just(sequenceData).bind(to: pickerView.rx.itemTitles) { _, item in return "\(item)" }

    }
    
    func createPicker() {
        doneToolBar.sizeToFit()
        doneToolBar.items = [doneBarButton]
        
        sequencePicker.inputAccessoryView = doneToolBar
        sequencePicker.inputView = pickerView
        
        areaPicker.inputAccessoryView = doneToolBar
        areaPicker.inputView = pickerView
    }
    
    private func constantraint() {
        logoView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.top.equalTo(view.frame.height/3)
        }
        sequencePicker.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(logoView.snp.bottom).offset(20)
            make.leading.equalTo(50)
        }
        areaPicker.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(logoView.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-50)
        }
        tableView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(sequencePicker.snp.bottom).offset(13)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
        
    }
    
}

extension MainViewController: UIPickerViewDelegate, UITableViewDelegate {
 
    
    
}

