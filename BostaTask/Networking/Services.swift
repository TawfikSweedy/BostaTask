//
//  AuthServices.swift
//  TemplateMVVM
//
//  Created by Tawfik Sweedy✌️ on 3/22/22.
//

import Foundation
import Moya

enum Services {
    case Users
    case Albums
    case Photos
}
extension Services : URLRequestBuilder {
    var path: String {
        switch self {
        case .Users:
            return EndPoints.users.rawValue
        case .Albums:
            return EndPoints.albums.rawValue
        case .Photos:
            return EndPoints.photos.rawValue
        }
    }
    var method: Moya.Method {
        switch self {
        case .Users , .Albums , .Photos  :
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .Users , .Albums , .Photos  :
        return .requestPlain
        }
    }
}
