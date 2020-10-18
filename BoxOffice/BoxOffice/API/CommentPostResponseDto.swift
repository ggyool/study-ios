//
//  CommentPostResponseDto.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/18.
//

import Foundation

struct CommentPostResponseDto: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case rating, timestamp, writer, contents
    }
}

