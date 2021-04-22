//
//  VerificationViewModel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/22.
//

import Foundation

import RxSwift
import RxCocoa

class VertificationViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let email: Driver<String>
        let code: Driver<String>
        let doneTap: Driver<Void>
    }
    struct Output {
        let result: Signal<String>
        let isEnable: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.code, input.email)
        let isEnable = info.map { !$0.0.isEmpty && !$0.1.isEmpty }
        let result = PublishSubject<String>()
        
        input.doneTap.asObservable().withLatestFrom(info).subscribe(onNext: { [weak self] code, email in
            api.verification(code, email).subscribe(onNext: { response in
                switch response {
                case .ok:
                    result.onCompleted()
                case .forbidden:
                    result.onNext("forbidden")
                case .preconditionFailed:
                    result.onNext("preconditionFailed")
                default:
                    result.onNext("default")
                }
            }).disposed(by: self!.disposeBag)
        }).disposed(by: disposeBag)
        
        return Output(result: result.asSignal(onErrorJustReturn: ""), isEnable: isEnable.asDriver())
    }
}
