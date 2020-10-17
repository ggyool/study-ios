//
//  CommentPostRequestDto.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/16.
//

import Foundation

struct CommentPostRequestDto: Codable {
    let rating: Double
    let writer: String
    let movieId: String
    let contents: String
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case rating, writer, contents
    }
}


