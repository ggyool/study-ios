//
//  ActionSheet.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/08.
//

import UIKit

// 공통적인 것을 처리하려면 좋은 방법이 있는지?
class Common {
    
    static let fullStarImage: UIImage? = UIImage(named: "ic_star_large_full")
    static let halfStarImage: UIImage? = UIImage(named: "ic_star_large_half")
    static let emptyStarImage: UIImage? = UIImage(named: "ic_star_large")
    
    static var alertController: UIAlertController = {
        let title: String = "정렬방식 선택"
        let message: String = "영화를 어떤 순서로 정렬할까요?"
        let style: UIAlertController.Style = .actionSheet
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let rateAlertAction: UIAlertAction = UIAlertAction(title: "예매율", style: .default, handler: {
            action in
            requestMovies(OrderType.reservationRate)
        })
        let curationAlertAction: UIAlertAction = UIAlertAction(title: "큐레이션", style: .default, handler: {
            action in
            requestMovies(OrderType.curation)
        })
        let dateAlertAction: UIAlertAction = UIAlertAction(title: "개봉일", style: .default, handler: {
            action in
            requestMovies(OrderType.releaseDate)
        })
        let cancelAlertAction: UIAlertAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: {
            action in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(rateAlertAction)
        alertController.addAction(curationAlertAction)
        alertController.addAction(dateAlertAction)
        alertController.addAction(cancelAlertAction)
        return alertController
    }()
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static var commentDateFormatter: DateFormatter = {
        let formatter = DateFormatter();
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static var numberFormatter: NumberFormatter = {
        let formetter = NumberFormatter()
        formetter.numberStyle = .decimal
        return formetter
    }()
    
}
