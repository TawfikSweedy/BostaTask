//
//  AlbumsModel.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import Foundation

struct AlbumsModel : Codable {
    let userId : Int?
    let id : Int?
    let title : String?
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
    }
}
