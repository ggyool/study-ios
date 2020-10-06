//
//  OrderType.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/06.
//

import Foundation

enum OrderType: Int, Codable {
    case reservationRate = 0
    case curation = 1
    case releaseDate = 2
    
    func getNavigationTitleString() -> String {
        switch self {
        case .reservationRate:
            return "예매율 순"
        case .curation:
            return "큐레이션"
        case .releaseDate:
            return "개봉일 순"
        }
    }
        
}
