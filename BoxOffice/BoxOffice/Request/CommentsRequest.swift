//
//  CommentsRequest.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/14.
//

import Foundation

let DidReceiveCommentsNotification: Notification.Name = Notification.Name("DidReceiveComments")

func requestComments(movieId: String) {
    guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/comments?movie_id=" + movieId) else {
        return
    }
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) {
        (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else { return }
        do{
            let jsonDecoder: JSONDecoder = JSONDecoder()
            let commentsResponse: CommentsGetResponseDto = try jsonDecoder.decode(CommentsGetResponseDto.self, from: data)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: DidReceiveCommentsNotification, object: nil, userInfo:["comments" : commentsResponse.comments])
            }
        } catch(let err) {
            print(err.localizedDescription)
        }
        
    }
    dataTask.resume()
}

