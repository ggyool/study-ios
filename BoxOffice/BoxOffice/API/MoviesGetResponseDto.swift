//
//  MoviesGetResponse.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/06.
//

import Foundation

struct MoviesGetResponseDto: Codable {

    let orderType: OrderType
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies
        case orderType = "order_type"
    }
}



