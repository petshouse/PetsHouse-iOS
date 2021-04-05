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
            return "/auth "
        case .uploadImage:
            return "/media"
        case .loadImage:
            return "/media-loadImage"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn,.signUp, .uploadImage, .loadImage:
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
        case .uploadImage(let image):
            return .uploadMultipart([Moya.MultipartFormData(provider: .data(image ?? Data()), name: "image", fileName: "image.jpg", mimeType: "image/jpg")])
        case .loadImage(let image):
            return .uploadMultipart([Moya.MultipartFormData(provider: .data(image ?? Data()), name: "image", fileName: "image.jpg", mimeType: "image/jpg")])
        }
    }

    var headers: [String : String]? {
        switch self {
        case .signIn, .signUp, .uploadImage, .loadImage:
            return nil
        }
    }

}
