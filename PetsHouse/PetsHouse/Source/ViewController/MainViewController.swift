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


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        doneBarButton.rx.tap.subscribe(onNext: { _ in
            let selectRow = self.pickerView.selectedRow(inComponent: 0)
            self.sequencePicker.text = self.sequenceData[selectRow]
            self.sequencePicker.resignFirstResponder()
        }).disposed(by: disposeBag)
            
    }
    
    func pickerBind() {
        
        pickerView.delegate = self
        pickerView.dataSource = nil
        sequencePicker.inputView = pickerView
        
        _ = Observable.just(sequenceData).bind(to: pickerView.rx.itemTitles) { _, item in return "\(item)" }

    }
    
    func createPicker() {
        doneToolBar.sizeToFit()
        doneToolBar.items = [doneBarButton]
        
        sequencePicker.inputAccessoryView = doneToolBar
        sequencePicker.inputView = pickerView
    }
    
}

extension MainViewController: UIPickerViewDelegate {
    
}

