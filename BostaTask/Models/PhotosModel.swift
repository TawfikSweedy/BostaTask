//
//  PhotosModel.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import Foundation
struct PhotosModel : Codable {
    let albumId : Int?
    let id : Int?
    let title : String?
    let url : String?
    let thumbnailUrl : String?
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
}
