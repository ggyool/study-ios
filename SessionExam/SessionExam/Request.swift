//
//  RequestFriends.swift
//  SessionExam
//
//  Created by ggyool on 2020/10/01.
//  Copyright © 2020 ggyool. All rights reserved.
//

import Foundation

let DidReceiveFriendsNotification: Notification.Name = Notification.Name("DidReceiveFriends")

func requestFriends() {
    guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else {
        return
    }
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) {
        (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else {return}
        
        do {
            let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: DidReceiveFriendsNotification, object: nil, userInfo:["friends" : apiResponse.results])
            }
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}
