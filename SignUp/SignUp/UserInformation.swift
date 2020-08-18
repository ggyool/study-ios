//
//  UserInformation.swift
//  SignUp
//
//  Created by ggyool on 2020/08/17.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
    var id: String?
    var password: String?
    var intoroduction: String?
    var phone: String?
    var birth: Date?
    static func setValues(dto: UserInformationDto){
        shared.id = dto.id
        shared.password = dto.password
        shared.intoroduction = dto.intoroduction
        shared.phone = dto.phone
        shared.birth = dto.birth
    }
    static func isEmpty()->Bool{
        return shared.id==nil
    }
    static func getId()->String{
        return shared.id!
    }
}

