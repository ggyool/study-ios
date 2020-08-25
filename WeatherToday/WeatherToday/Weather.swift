//
//  Weather.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/23.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation
import UIKit

class Weather: Codable {
    
    let cityName: String
    let weatherType: WeatherType
    let celsius: Double
    let rainfallProbability: Int
    
    enum CodingKeys: String, CodingKey {
        case celsius
        case weatherType = "state"
        case cityName = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
    
    var fahrenheit: Double {
        let fahrenheit: Double = celsius * 9 / 5 + 32
        // 소수 2번째 자리에서 반올림
        return (fahrenheit*10).rounded()/10
    }
    var iconImage: UIImage? {
        return UIImage(named: weatherType.getImageName())
    }
    var temperatureText: String {
        return  "섭씨 \(celsius)도 / 화씨 \(fahrenheit)도"
    }
    var rainfallText: String {
        return "강수확률 \(rainfallProbability)%"
    }
    
}

