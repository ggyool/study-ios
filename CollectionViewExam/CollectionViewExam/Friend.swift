//
//  Friend.swift
//  CollectionViewExam
//
//  Created by ggyool on 2020/08/29.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation

struct Friend: Codable {
    
    struct Address: Codable {
        let country: String
        let city: String
    }
    
    let name: String
    let age: Int
    let addressInfo: Address
    
    var nameAndAge: String {
        return name + " \(age)"
    }
    
    var fullAddress: String {
        return addressInfo.city + ", " + addressInfo.country
    }
    
    enum CodingKeys: String, CodingKey {
        case name, age
        case addressInfo =  "address_info"
    }

    
}
