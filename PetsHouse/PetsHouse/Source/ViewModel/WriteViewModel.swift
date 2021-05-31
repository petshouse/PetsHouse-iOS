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
        let area: Driver<String>
        let doneTap: Driver<Void>
    }
    
    struct Output {
        let result: Signal<String>
        let selectImage: Signal<String>
        let isEnable: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.titleText, input.postText, input.selectImage, input.area )
        let isEnable = info.map { !$0.0.isEmpty }
        let result = PublishSubject<String>()
        let selectImage = PublishSubject<String>()

        input.doneTap.asObservable().withLatestFrom(info).subscribe(onNext: { [weak self] title, post,media, area in
            guard let self = self else { return }
            api.uploadImage(media).subscribe(onNext: { data, response  in
                print(response)
                switch response {
                case .ok:
                    result.onCompleted()
                    print("upload image ok")
                    api.writePost(title, post, data?.media ?? " ", area).subscribe(onNext: { _, response in
//                        print(response)
                        switch response {
                        case .ok:
                            result.onCompleted()
                            print("ok")
                        case .forbidden:
                            result.onNext("실패")
                            print("forbidden")
                        case .preconditionFailed:
                            result.onNext("preconditionFailed")
                            print("predi")
                        default:
                            result.onNext("write default")
                        }
                    }).disposed(by: self.disposeBag)
                case .forbidden:
                    result.onNext("forbidden")
                case .preconditionFailed:
                    result.onNext("preconditionFailed")
                default:
                    result.onNext("write default")
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)

        return Output(result: result.asSignal(onErrorJustReturn: "실패"), selectImage: selectImage.asSignal(onErrorJustReturn: ""), isEnable: isEnable.asDriver())
    }
}
