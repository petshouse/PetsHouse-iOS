//
//  WriteViewModel.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/04.
//

import Foundation

import RxSwift
import RxCocoa

class WriteViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let titleText: Driver<String>
        let postText: Driver<String>
        let selectImage: Driver<Data?>
        let doneTap: Driver<Void>
    }
    
    struct Output {
        let result: Signal<String>
        let isEnable: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.titleText, input.selectImage, input.postText, input.doneTap)
        let isEnable = info.map { !$0.0.isEmpty }
        let result = PublishSubject<String>()
        
        input.doneTap.asObservable().withLatestFrom(info).subscribe(onNext: { [weak self] title, media, content, _ in
            guard let self = self else { return }
            api.uploadImage(media).subscribe(onNext: { _ ,response in
                switch response {
                case .ok:
                    result.onCompleted()
                case .forbidden:
                    result.onNext("forbidden")
                case .preconditionFailed:
                    result.onNext("preconditionFailed")
                default:
                    print("default")
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        return Output(result: result.asSignal(onErrorJustReturn: "실패"), isEnable: isEnable.asDriver())
    }
}
