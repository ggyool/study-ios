//
//  GradeType.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/10.
//

import Foundation
import UIKit

let allAgeImage: UIImage? = UIImage(named: "ic_allages")
let twelveImage: UIImage? = UIImage(named: "ic_12")
let fifteenImage: UIImage? = UIImage(named: "ic_15")
let nineteenImage: UIImage? = UIImage(named: "ic_19")

enum GradeType: Int, Codable {
    case all = 0
    case twelve = 12
    case fifteen = 15
    case nineteen = 19
    
    func getImage() -> UIImage? {
        switch self {
        case .all:
            return allAgeImage
        case .twelve:
            return twelveImage
        case .fifteen:
            return fifteenImage
        case .nineteen:
            return nineteenImage
        }
    }
}
