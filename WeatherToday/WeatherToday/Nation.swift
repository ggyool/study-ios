//
//  Nation.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/26.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation

struct Nation: Codable {
    let name: String
    let koreanName: String
    enum CodingKeys: String, CodingKey {
        case name = "asset_name"
        case koreanName = "korean_name"
    }
}
