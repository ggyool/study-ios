//
//  Comment.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/14.
//

import Foundation

class Comment: Codable {
    
    let rating: Double
    let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case rating, timestamp, writer, contents, id
    }
    
}
