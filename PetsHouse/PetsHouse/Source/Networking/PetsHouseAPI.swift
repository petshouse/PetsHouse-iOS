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
    case checkEmail(_ email: String)
    case emailSend(_ email: String)
    case verification(_ code: String, _ email: String)
    case uploadImage(_ image: Data?)
    case loadImage(_ image: String)
    case loadPost
    case writePost(_ title: String, _ description: String, _ mediaId: String, _ area: String)
}

extension PetsHouseAPI: TargetType {

    var baseURL: URL {
        return URL(string: "http://13.124.126.51:5000")!
    }

    var path: String {
        switch self {
        case .signIn:
            return "/api/v1/login"
        case .signUp:
            return "/api/v1/auth"
        case .checkEmail:
            return "/api/v1/id"
        case .emailSend:
            return "/api/v1/emailsend"
        case .verification:
            return "/api/v1/verification"
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
        case .signIn,.signUp,.checkEmail,.emailSend,.uploadImage, .writePost:
            return .post
        case .loadPost, .loadImage, .verification:
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
        case .checkEmail(let email):
            return  .requestParameters(parameters: ["email": email], encoding: JSONEncoding.prettyPrinted)
        case .emailSend(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.prettyPrinted)
        case .uploadImage(let image):
            return .uploadMultipart([Moya.MultipartFormData(provider: .data(image ?? Data()), name: "image", fileName: "image.jpg", mimeType: "image/jpg")])
        case .loadImage(let image):
            return .requestParameters(parameters: ["image": image], encoding: JSONEncoding.prettyPrinted)
        case .writePost(let title, let description, let mediaId, let area):
            return .requestParameters(parameters: ["title": title, "description": description, "mediaId": mediaId, "area": area], encoding: JSONEncoding.prettyPrinted)

        default:
            return .requestPlain
        }
    }
    
    
    var headers: [String : String]? {
        switch self {
        case .signIn, .signUp, .checkEmail,.emailSend, .verification:
            return nil
        case .uploadImage, .loadImage, .loadPost, .writePost:
            guard let token = TokenManager.currentToken?.accessToken else { return nil }
            return ["Authorization" : "Bearer " + token]

        }
    }
}
