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
    var selectIndexPath = PublishRelay<Int>()

    
    private let logoView = UIImageView().then {
        $0.image = UIImage(named: "Text Logo")
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
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(loadData: loadData.asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input: input)
        
        output.loadData.bind(to: tableView.rx.items(cellIdentifier: "mainCell", cellType: MainCell.self)) { row, element, cell in
            cell.nameLbl.text = element.nickname
            cell.titleTxtField.text = element.title
            cell.contentTxtView.text = element.description
            cell.postImage.image = UIImage(named: element.media)
            cell.timeLbl.text = element.date
            cell.sirenBtn.rx.tap.subscribe(onNext: { _ in
                self.selectIndexPath.accept(row)
            }).disposed(by: self.disposeBag)
            
        }.disposed(by: disposeBag)
    }
    
    func setUI() {
        let cell = MainCell()
        
        doneBarButton.rx.tap.subscribe(onNext: { _ in
            let selectRow = self.pickerView.selectedRow(inComponent: 0)
            self.sequencePicker.text = self.sequenceData[selectRow]
            self.sequencePicker.resignFirstResponder()
            self.areaPicker.text = self.areaData[selectRow]
            self.areaPicker.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        cell.moreBtn.rx.tap.subscribe(onNext: { _ in
            let actionSheet = UIAlertController(title: "부적절한 게시글입니까?", message: "", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "신고하기", style: .default, handler: nil)
            
            actionSheet.addAction(action)
            self.present(actionSheet, animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
        
        tableView.delegate = self
        tableView.dataSource = nil
        tableView.register(MainCell.self, forCellReuseIdentifier: "mainCell")
        tableView.rowHeight = 220
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
            make.centerX.equalTo(view)
            make.top.equalTo(view.frame.height/15)
            make.width.equalTo(170)
            make.height.equalTo(70)
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

