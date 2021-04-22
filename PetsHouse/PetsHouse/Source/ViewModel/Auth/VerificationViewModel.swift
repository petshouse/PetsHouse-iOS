//
//  VerificationViewModel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/21.
//

import Foundation

import RxSwift
import RxCocoa

class VertificationViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let code: Driver<String>
        let doneTap: Driver<Void>
    }
    struct Output {
        let isEnable: Driver<Bool>
        let result: Signal<String>
    }
    
    func transform(input: Input) -> Output {
        let api = Service()
        let info = input.code
        let isEnable = info.map { !$0.isEmpty }
        let result = PublishSubject<String>()
        
        input.doneTap.asObservable().withLatestFrom(info).subscribe(onNext: { [weak self] code in
            api.verification(code).subscribe(onNext: { response in
                switch response {
                case .success:
                    result.onCompleted()
                case .forbidden:
                    result.onNext("forbidden")
                case .preconditionFailed:
                    result.onNext("preconditionFailed")
                default:
                    print("vertification default")
                }
            }).disposed(by: self!.disposeBag)
        }).disposed(by: disposeBag)
        
        return Output(isEnable: isEnable.asDriver(), result: result.asSignal(onErrorJustReturn: ""))
    }
}
