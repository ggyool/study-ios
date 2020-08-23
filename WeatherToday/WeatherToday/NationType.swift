//
//  NationType.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/23.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation

enum NationType: String{
    case kr, de, it, us, fr, jp
    func toKorean() -> String{
        switch self {
        case .kr:
            return "대한민국"
        case .de:
            return "독일"
        case .it:
            return "이탈리아"
        case .us:
            return "미국"
        case .fr:
            return "프랑스"
        case .jp:
            return "일본"
        }
    }
}
