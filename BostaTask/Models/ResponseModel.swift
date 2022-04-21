//
//  ResponseModel.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import Foundation
struct ResponseModel : Codable{
    let status : Int?
    let msg : String?
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case msg = "message"
    }
}
