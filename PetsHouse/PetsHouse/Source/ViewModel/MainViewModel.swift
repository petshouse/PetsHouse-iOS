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
        let loadImage: Signal<Data>
    }
    struct Output {
        let result: Signal<String>
        let loadData: BehaviorRelay<[MainModel]>
        let loadImage: BehaviorRelay<[loadImageModel]>
    }
    
    func transform(input: Input) -> Output {
        let api = Service()
        let result = PublishSubject<String>()
        let loadData = BehaviorRelay<[MainModel]>(value: [])
        let loadImage = BehaviorRelay<[loadImageModel]>(value: [])

        input.loadData.asObservable().subscribe(onNext: { _ in
            api.loadPost().asObservable().subscribe(onNext: { data, response in
                switch response {
                case .success:
                    result.onCompleted()
                    api.loadImage(data?.mediaName ?? " ").subscribe(onNext: { _, response in
                        switch response {
                        case .success:
                            result.onCompleted()
                        case .forbidden:
                            result.onNext("forbidden")
                        case .preconditionFailed:
                            result.onNext("preconditionFailed")
                        default:
                            result.onNext("image default")
                        }
                    }).disposed(by: self.disposeBag)
                case .forbidden:
                    result.onNext("forbidden")
                case .preconditionFailed:
                    result.onNext("preconditionFailed")
                default:
                    result.onNext("main default")
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        return Output(result: result.asSignal(onErrorJustReturn: ""), loadData: loadData, loadImage: loadImage)
    }
}
