//
//  UserInformation.swift
//  SingletonPatternExam
//
//  Created by ggyool on 2020/08/15.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
    var name: String?
    var age: String?
}
