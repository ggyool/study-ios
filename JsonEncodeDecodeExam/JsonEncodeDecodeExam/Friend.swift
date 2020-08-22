//
//  Friend.swift
//  JsonEncodeDecodeExam
//
//  Created by ggyool on 2020/08/22.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation

struct Friend: Codable{
    
    struct Address: Codable{
        let country: String
        let city: String
    }
    let name: String
    let age: Int
    let addressInfo: Address
    var nameAndAge: String {
        return self.name + "(\(self.age))"
    }
    var fullAddress: String {
        return self.addressInfo.city + ", " + self.addressInfo.country
    }
    enum CodingKeys: String, CodingKey{
        case name, age
        case addressInfo = "address_info"
    }
    
}
