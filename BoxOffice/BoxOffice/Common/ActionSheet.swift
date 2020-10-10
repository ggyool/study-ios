//
//  ActionSheet.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/08.
//

import UIKit


class OrderModal: UIAlertController {
    static let shared: OrderModal = OrderModal()
    private init() {
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
    }
}
