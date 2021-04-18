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
    case loadPost
    case writePost(_ title: String, _ description: String, _ mediaId: String)
}

extension PetsHouseAPI: TargetType {

    var baseURL: URL {
        return URL(string: "/api")!
    }

    var path: String {
        switch self {
        case .signIn:
            return "/api/v1/login"
        case .signUp:
            return "/api/v1/auth "
        case .verification:
            return "/api/v1/verification/:code"
        case .uploadImage:
            return "/api/v1/media"
        case .loadImage:
            return "/api/v1/loadimage/:media"
        case .loadPost:
            return "/api/v1/post"
        case .writePost:
            return "/api/v1/post"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn,.signUp,.verification,.uploadImage, .writePost:
            return .post
        case .loadPost, .loadImage:
            return .get
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
        case .writePost(let title, let description, let mediaId):
            return .requestParameters(parameters: ["title": title, "description": description, "mediaId": mediaId], encoding: JSONEncoding.prettyPrinted)

        default:
            return .requestPlain
        }
    }
    
    
    var headers: [String : String]? {
        switch self {
        case .signIn, .signUp,.verification:
            return nil
        case .uploadImage, .loadImage, .loadPost, .writePost:
            guard let token = TokenManager.currentToken?.accessToken else { return nil }
            return ["Authorization" : "Bearer " + token]

        }
    }
}
