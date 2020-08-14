//
//  DataCenter.swift
//  MeetingRooms
//
//  Created by ggyool on 2020/08/14.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation

let dataCenter: DataCenter = DataCenter()

class DataCenter{
    var branches: [Branch] = []
    init(){
        let roomA = MeetingRoom(name: "A",  capacity: 3)
        let roomB = MeetingRoom(name: "B",  capacity: 4)
        let roomC = MeetingRoom(name: "C",  capacity: 5)
        let roomD = MeetingRoom(name: "D",  capacity: 6)
        
        let serviceA = Service(name: "serviceA")
        let serviceB = Service(name: "serviceB")
        let serviceC = Service(name: "serviceC")
        serviceA.items = [roomA, roomB, roomC, roomD]
        
        
        let branchA = Branch(name: "branchA")
        let branchB = Branch(name: "branchB")
        branchA.services = [serviceA, serviceB, serviceC]
        branches += [branchA, branchB]
    }
}

class Branch{
    let name: String
    var services: [Service]?
    init(name: String){
        self.name = name
    }
}

class Service{
    let name: String
    var items: [MeetingRoom]?
    init(name: String){
        self.name = name
    }
}

class MeetingRoom{
    let name: String
    let capacity: Int
    init(name: String, capacity: Int){
        self.name = name
        self.capacity = capacity
    }
}
