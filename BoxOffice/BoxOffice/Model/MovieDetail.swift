//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/10.
//

import Foundation

class MovieDetail: Codable {
    
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let grade: GradeType
    let image: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: Date
    let id: String
    
    var dateString: String {
        return Common.dateFormatter.string(from: date)
    }
    enum CodingKeys: String, CodingKey {
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
        case audience, actor, duration, director, synopsis, genre, grade,image, title, date, id
    
    }

}
