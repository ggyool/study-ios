//
//  WeatherType.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/23.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation
import UIKit

enum WeatherType: Int, Codable {
    case sunny = 10
    case cloudy = 11
    case rainy = 12
    case snowy = 13
    
    func getImageName() -> String{
        switch self {
        case .sunny:
            return "sunny"
        case .cloudy:
            return "cloudy"
        case .rainy:
            return "rainy"
        case .snowy:
            return "snowy"
        }
    }
    
    func toKorean() -> String{
        switch self {
        case .sunny:
            return "맑음"
        case .cloudy:
            return "흐림"
        case .rainy:
            return "비"
        case .snowy:
            return "눈"
        }
    }
    
}

