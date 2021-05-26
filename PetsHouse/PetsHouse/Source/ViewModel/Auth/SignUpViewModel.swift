//
//  SignUpViewModel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/02.
//

import Foundation

import RxSwift
import RxCocoa

class SignUpViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let nickname: Driver<String>
        let email: Driver<String>
        let password: Driver<String>
        let duplicateTap: Driver<Void>
        let doneTap: Driver<Void>
    }
    struct Output {
        let duplicateCheck: Signal<String>
        let result: Signal<String>
        let isEnable: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let api = Service()
        let result = PublishSubject<String>()
        let duplicate = PublishSubject<String>()
        let info = Driver.combineLatest(input.nickname, input.email, input.password)
        let isEnable = info.map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty }
        
        input.doneTap.asObservable().withLatestFrom(info).subscribe(onNext: { [weak self] nickname, email, password in
            guard let self = self else { return }
            api.signUP(nickname, email, password).subscribe(onNext: { response in
                switch response {
                case .ok:
                    result.onCompleted()
                case .forbidden:
                    result.onNext("forbidden")
                case .preconditionFailed:
                    result.onNext("preconditionFailed")
                default:
                    result.onNext("회원가입 실패")
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        input.duplicateTap.asObservable().withLatestFrom(input.email).subscribe(onNext: { [weak self] email in
            guard let self = self else { return }
            api.checkEmail(email).subscribe(onNext: { response in
                switch response {
                case .success:
                    result.onCompleted()
                case .preconditionFailed:
                    result.onNext("중복된 이메일")
                default:
                    result.onNext("error")
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        return Output(duplicateCheck: duplicate.asSignal(onErrorJustReturn: ""), result: result.asSignal(onErrorJustReturn: "회원가입 실패"), isEnable: isEnable.asDriver())
    }
}
