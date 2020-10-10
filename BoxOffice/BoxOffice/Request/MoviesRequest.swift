//
//  MoviesRequest.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/06.
//

import Foundation

let DidReceiveMoviesNotification: Notification.Name = Notification.Name("DidReceiveMovies")

func requestMovies(_ orderType: OrderType = .reservationRate) {
    guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=\(orderType.rawValue)") else {
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
            // String 으로 받아서 Movie에서는 Date로 받고 싶어서 이렇게 함
            let jsonDecoder: JSONDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(Common.dateFormatter)
            let moviesResponse: MoviesGetResponseDto = try jsonDecoder.decode(MoviesGetResponseDto.self, from: data)
            // background thread에서 실행되고 있었으므로 넣었다.
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: DidReceiveMoviesNotification, object: nil, userInfo:["movies" : moviesResponse.movies, "orderType" : orderType])
            }
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}
