//
//  PetsHouseAPI.swift
//  PetsHouse
//
//  Created by 문지수 on 2021/04/01.
//

import Foundation
import Moya

enum PetsHouseAPI {
    case signIn(_ email: String, _ password: String)
    case signUp(_ nickname: String, _ email: String, _ password: String)
    case verification(_ code: String)
    case uploadImage(_ image: Data?)
    case loadImage(_ image: Data?)
}

extension PetsHouseAPI: TargetType {
    var baseURL: URL {
        return URL(string: "/api")!
    }

    var path: String {
        switch self {
        case .signIn:
            return "/auth"
        case .signUp:
            return "/api/v1/auth "
        case .verification:
            return "/api/v1/verification/:code"
        case .uploadImage:
            return "/api/v1/media"
        case .loadImage:
            return "/api/v1/loadimage/:media"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn,.signUp,.verification,.uploadImage, .loadImage:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .signIn(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.prettyPrinted)
        case .signUp(let nickname, let email, let password):
            return .requestParameters(parameters: ["nickname": nickname,"email": email, "password": password], encoding: JSONEncoding.prettyPrinted)
        case .verification(let code):
            return .requestParameters(parameters: ["code": code], encoding: JSONEncoding.prettyPrinted)
        case .uploadImage(let image):
            return .uploadMultipart([Moya.MultipartFormData(provider: .data(image ?? Data()), name: "image", fileName: "image.jpg", mimeType: "image/jpg")])
        case .loadImage(let image):
            return .uploadMultipart([Moya.MultipartFormData(provider: .data(image ?? Data()), name: "image", fileName: "image.jpg", mimeType: "image/jpg")])
        }
    }

    var headers: [String : String]? {
        switch self {
        case .signIn, .signUp,.verification,.uploadImage, .loadImage:
            return nil
        }
    }

}
