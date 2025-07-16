//
//  TmdbConfigurationModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//

struct TmdbConfigurationModel: Decodable {
    let images: TmdbImagesModel
    let changeKeys: [String]
    
    enum CodingKeys: String, CodingKey {
        case images = "images"
        case changeKeys = "change_keys"
    }
}
