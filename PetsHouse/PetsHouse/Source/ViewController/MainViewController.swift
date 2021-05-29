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
    private let loadImage = BehaviorRelay<Data>(value: Data())
    var selectIndexPath = PublishRelay<Int>()
    
    @IBOutlet weak var sequencePicker: UIPickerView!
    @IBOutlet weak var areaPicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUI()
        bindViewModel()
        picker()
    }

    func picker() {
        Observable.just(["최신순", "우선순위"])
            .bind(to: sequencePicker.rx.itemTitles) { _, item in
                return "\(item)"
            }.disposed(by: disposeBag)
        
        sequencePicker.rx.itemSelected
            .subscribe(onNext: { (row, value) in
                NSLog("selected: \(row)")
            }).disposed(by: disposeBag)
        
        Observable.just(["서울", "대전", "광주", "대구", "부산", "울산", "제주", "강원", "경기", "전남","전북", "경남","경북","충남","충북"])
            .bind(to: areaPicker.rx.itemTitles) { _, item in
                return "\(item)"
            }.disposed(by: disposeBag)
        
        areaPicker.rx.itemSelected.subscribe(onNext: { (row, value) in
            NSLog("selected: \(row)")
        }).disposed(by: disposeBag)
    }

    
    func bindViewModel() {
        let input = MainViewModel.Input(loadData: loadData.asSignal(onErrorJustReturn: ()),
                                        loadImage: loadImage.asSignal(onErrorJustReturn: Data()))
        let output = viewModel.transform(input: input)
        
        output.loadData.bind(to: tableView.rx.items(cellIdentifier: "mainCell", cellType: MainCell.self)) { row, element, cell in
//            cell.nameLbl.text = element.nickname
            cell.titleTxtField.text = element.title
            cell.contentTxtView.text = element.description
            cell.postImage.image = UIImage(named: element.mediaName)
            cell.timeLbl.text = element.date
            cell.sirenBtn.rx.tap.subscribe(onNext: { _ in
                self.selectIndexPath.accept(row)
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
    
    func setUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Text Logo")
        imageView.image = image
        navigationItem.titleView = imageView
        self.navigationItem.setHidesBackButton(true, animated: true)

        

        let cell = MainCell()
        cell.moreBtn.rx.tap.subscribe(onNext: { _ in
            let actionSheet = UIAlertController(title: "부적절한 게시글입니까?", message: "", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "신고하기", style: .default, handler: nil)
            actionSheet.addAction(action)
            self.present(actionSheet, animated: true, completion: nil)
        }).disposed(by: self.disposeBag)

        tableView.register(MainCell.self, forCellReuseIdentifier: "mainCell")
        tableView.rowHeight = 220
        
        tableView.delegate = self
        tableView.dataSource = nil
    }
    
}

extension MainViewController: UITableViewDelegate {

}
