//
//  CommentRequest.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/18.
//

import Foundation


func requestComment(commentPostRequestDto: CommentPostRequestDto) {
    guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/comment") else {
        return
    }
    let session: URLSession = URLSession(configuration: .default)
    var request: URLRequest = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let jsonEncoder: JSONEncoder = JSONEncoder()
    do {
        let data: Data = try jsonEncoder.encode(commentPostRequestDto)
        request.httpBody = data
    } catch(let err) {
        print(err.localizedDescription)
    }
    let dataTask: URLSessionDataTask = session.dataTask(with: request) {
        (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else { return }
        do{
            let jsonDecoder: JSONDecoder = JSONDecoder()
            let commentResponse: CommentPostResponseDto = try jsonDecoder.decode(CommentPostResponseDto.self, from: data)
            print("comment post response: ")
            print(commentResponse)
            requestComments(movieId: commentResponse.movieId)
        } catch(let err) {
            print(err.localizedDescription)
        }   
    }
    dataTask.resume()
}
