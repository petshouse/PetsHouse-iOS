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
            .map(TokenModel.self)
            .map{token -> (Network) in
                if StoregaeManager.shared.create(token) {return (.success)}
                return .fail
            }.catchError{ [unowned self] in return .just(self.setNetworkError($0))}
    }
    
    func checkEmail(_ email: String) -> Observable<Network> {
        return provider.rx.request(.checkEmail(email))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { _ -> Network in
                return (.success)
            }.catchError { [unowned self] in return .just(self.setNetworkError($0))}
    }
    
    func emailSend(_ email: String) -> Observable<Network> {
        return provider.rx.request(.emailSend(email))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { _ -> Network in
                return (.ok)
            }.catchError { [unowned self] in return .just(self.setNetworkError($0))}
    }
    
    func verification(_ code: String, _ email: String) -> Observable<Network> {
        return provider.rx.request(.verification(code, email))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { _ -> Network in
                return (.ok)
            }.catchError { [unowned self] in return .just(self.setNetworkError($0))}
    }
    
    func uploadImage(_ media: Data?) -> Observable<(Image?,Network)> {
        return provider.rx.request(.uploadImage(media))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map(Image.self)
            .map{ return ($0, .ok)}
            .catchError { error in
                print(error)
                return .just((nil, .fail))
            }
    }
    
    func loadImage(_ image: String) -> Observable<(ImageModel?, Network)> {
        return provider.rx.request(.loadImage(image))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map(ImageModel.self)
            .map{ return ($0, .success)}
            .catchError{ error in
                print(error)
                return .just((nil, .fail))}
    }
    
    func loadPost() -> Observable<(MainModel?,Network)> {
        return provider.rx.request(.loadPost)
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map(MainModel.self)
            .map { return ($0, .success)}
            .catchError{ error in
                print(error)
                return .just((nil, .fail))
            }
    }
    
    func writePost(_ title: String, _ description: String, _ mediaId: String, _ area: String) -> Observable<(Write?, Network)> {
        return provider.rx.request(.writePost(title, description, mediaId, area))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map(Write.self)
            .map { return ($0, .ok)}
            .catchError{ error in
                print(error)
                return .just((nil, .fail))}
    }
    
    func setNetworkError(_ error: Error) -> Network {
        guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fail) }
         print(error)
        return (Network(rawValue: status) ?? .fail)
     }
}
