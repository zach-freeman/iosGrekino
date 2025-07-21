//
//  UserModel.swift
//  grekino
//
//  Created by Zach Freeman on 7/21/25.
//
import FirebaseFirestore

struct UserModel: Identifiable, Codable {
    @DocumentID var id: String?
    var displayName: String
    var email: String
    var movieData : [MovieDataModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "DisplayName"
        case email = "Email"
        case movieData = "MovieData"
    }
}


struct MovieDataModel : Codable {
    var movieID : String
    var dateWatched : String
    var isWatched: Bool
    var review: String?
    var starRating: Double?
    
    enum CodingKeys: String, CodingKey {
        case movieID = "MovieId"
        case dateWatched = "DateWatched"
        case isWatched = "IsWatched"
        case review = "Review"
        case starRating = "StarRating"
    }
}
