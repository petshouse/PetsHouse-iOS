//
//  MainViewModel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/13.
//

import Foundation

import RxSwift
import RxCocoa

class MainViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let loadData: Signal<Void>
    }
    struct Output {
        let result: Signal<String>
        let loadData: BehaviorRelay<[MainModel]>
    }
    
    func transform(input: Input) -> Output {
        let api = Service()
        let result = PublishSubject<String>()
        let loadData = BehaviorRelay<[MainModel]>(value: [])
        
        input.loadData.asObservable()
            .flatMap{ api.loadPost()}
            .subscribe(onNext:  { _, response in
                switch response {
                case .success:
                    result.onCompleted()
                case .forbidden:
                    result.onNext("forbidden")
                case .preconditionFailed:
                    result.onNext("preconditionFailed")
                default:
                    print("default")
                }
            }).disposed(by: disposeBag)
        
        return Output(result: result.asSignal(onErrorJustReturn: ""), loadData: loadData)
    }
}
