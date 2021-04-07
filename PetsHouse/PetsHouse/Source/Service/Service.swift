//
//  Service.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/02.
//

import Foundation

import RxSwift
import Moya

class Service {
    let provider = MoyaProvider<PetsHouseAPI>()
    
    func signUP(_ nickname: String, _ email: String, _ password: String) -> Observable<Network> {
        return provider.rx.request(.signUp(nickname, email, password))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { _ -> Network in
                return (.ok)
            }.catchError { [unowned self] in return .just(self.setNetworkError($0)) }
    }
    
    func signIn(_ email: String, _ password: String) -> Observable<Network> {
        return provider.rx.request(.signIn(email, password))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { _ -> Network in
                return (.success)
            }.catchError{ [unowned self] in return .just(self.setNetworkError($0))}
    }
    
    func verification(_ code: String) -> Observable<Network> {
        return provider.rx.request(.verification(code))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { _ -> Network in
                return (.ok)
            }.catchError { [unowned self] in return .just(self.setNetworkError($0))}
    }
    
    func uploadImage(_ image: Data) -> Observable<Network> {
        return provider.rx.request(.uploadImage(image))
            .filterSuccessfulStatusCodes().asObservable()
            .map { _ -> Network in
                return (.success)
            }.catchError { [unowned self] in return .just(self.setNetworkError($0)) }
    }
    
    func loadImage(_ image: Data) -> Observable<Network> {
        return provider.rx.request(.loadImage(image))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { _ -> Network in
                return (.success)
            }.catchError { [unowned self] in return .just(self.setNetworkError($0)) }
    }
    
    func setNetworkError(_ error: Error) -> Network {
        guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fail) }
         print(error)
        return (Network(rawValue: status) ?? .fail)
     }
}
