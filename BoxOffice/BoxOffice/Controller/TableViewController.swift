//
//  TableViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/04.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var movies: [Movie] = []
    let allAgeImage: UIImage? = UIImage(named: "ic_allages")
    let twelveImage: UIImage? = UIImage(named: "ic_12")
    let fifteenImage: UIImage? = UIImage(named: "ic_15")
    let nineteenImage: UIImage? = UIImage(named: "ic_19")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMoviesNotification(_:)), name: DidReceiveMoviesNotification, object: nil)
        requestMovies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomTableViewCell  =
                tableView.dequeueReusableCell(withIdentifier: "TableIdentifier", for: indexPath) as? CustomTableViewCell else {
            preconditionFailure("테이블셀 불러오기 실패")
        }
        cell.titleLable.text = movies[indexPath.row].title
        cell.ratingLable.text = String(movies[indexPath.row].userRating)
        cell.rankingLable.text = String(movies[indexPath.row].reservationGrade)
        cell.bookingRateLable.text = String(movies[indexPath.row].reservationRate)
        cell.releaseDateLable.text = String(movies[indexPath.row].dateString)
        
        switch movies[indexPath.row].grade {
        case 12:
            cell.ageImageView.image = twelveImage
        case 15:
            cell.ageImageView.image = fifteenImage
        case 19:
            cell.ageImageView.image = nineteenImage
        default:
            cell.ageImageView.image = allAgeImage
        }
    
        DispatchQueue.global().async {
            // url이 http라서 info.plist에 ATS추가하였음
            guard let imageURL: URL = URL(string: self.movies[indexPath.row].thumb) else { preconditionFailure("thumbnail url 문제") }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { preconditionFailure("thumbnail image 불러오기 실패") }
            DispatchQueue.main.async {
                // 재사용 관련 처리를 하지 않아도 될지
                // 비동기로 인한 처리를 하지 않아도 될지
                cell.thumbImageView.image = UIImage(data: imageData)
//                if let index: IndexPath = tableView.indexPath(for: cell) {
//                    if index.row == indexPath.row {
//                        cell.imageView?.image = UIImage(data: imageData)
//                        cell.setNeedsLayout() // 이것만 쓰면 다음 draw cycle에
//                        cell.layoutIfNeeded() // 즉시 새로고침 하고 싶으면 씀
//                    }
//                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.14
    }
    
    
    
    @objc func didReceiveMoviesNotification(_ notification: Notification) {
        guard let movies: [Movie] = notification.userInfo?["movies"] as? [Movie] else {
            return
        }
        guard let orderType: OrderType = notification.userInfo?["orderType"] as? OrderType else {
            return
        }
        self.movies = movies
        self.tableView.reloadData()
        self.navigationItem.title = orderType.getNavigationTitleString()
    }

    @IBAction func touchUpOrderButton(_ sender: UIButton) {
        let alertController: UIAlertController = getActionSheet()
        self.present(alertController, animated: true, completion: {
            self.tableView.reloadData()
        })
    }
    
    func getActionSheet() -> UIAlertController {
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
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(rateAlertAction)
        alertController.addAction(curationAlertAction)
        alertController.addAction(dateAlertAction)
        alertController.addAction(cancelAlertAction)
        return alertController
    }
}

