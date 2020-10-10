//
//  MovieDetailRequest.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/10.
//

import Foundation

let DidReceiveMovieDetailNotification: Notification.Name = Notification.Name("DidReceiveMovieDetail")

func requestMovieDetail(movieId: String) {
    guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movie?id=" + movieId) else {
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
            jsonDecoder.dateDecodingStrategy = .formatted(Common.dateFormatter)
            let movieDetailResponse: MovieDetail = try jsonDecoder.decode(MovieDetail.self, from: data)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: DidReceiveMovieDetailNotification, object: nil, userInfo:["movieDetail" : movieDetailResponse])
            }
        } catch(let err) {
            print(err.localizedDescription)
        }
        
    }
    dataTask.resume()
}
