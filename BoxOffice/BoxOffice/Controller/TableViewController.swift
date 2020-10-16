//
//  TableViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/04.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    weak var myTabBarController: TabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTabBarController = self.parent?.parent as? TabBarController
        self.navigationItem.rightBarButtonItem?.target = self.myTabBarController
        self.navigationItem.rightBarButtonItem?.action = #selector(self.myTabBarController.touchUpOrderButton(_:))
        configureRefreshController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureRefreshController() {
        let refreshController: UIRefreshControl = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(pullDownTableView), for: .valueChanged)
        self.tableView.refreshControl = refreshController
    }
    
    @objc func pullDownTableView() {
        requestMovies(myTabBarController.orderType)
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func refreshNavigationItem(_ orderType: OrderType) {
        self.navigationItem.title = orderType.getNavigationTitleString()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTabBarController.movies.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomTableViewCell  =
                tableView.dequeueReusableCell(withIdentifier: "TableIdentifier", for: indexPath) as? CustomTableViewCell else {
            preconditionFailure("테이블셀 불러오기 실패")
        }
        print("table refresh")
        let movie: Movie = myTabBarController.movies[indexPath.row]
        cell.titleLable.text = movie.title
        cell.ratingLable.text = String(movie.userRating)
        cell.rankingLable.text = String(movie.reservationGrade)
        cell.bookingRateLable.text = String(movie.reservationRate)
        cell.releaseDateLable.text = String(movie.dateString)
        cell.ageImageView.image = movie.grade.getImage()
    
        DispatchQueue.global().async {
            // url이 http라서 info.plist에 ATS추가하였음
            guard let imageURL: URL = URL(string: movie.thumb) else { preconditionFailure("thumbnail url 문제") }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { preconditionFailure("thumbnail image 불러오기 실패") }
            DispatchQueue.main.async {
                cell.thumbImageView.image = UIImage(data: imageData)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.14
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController: DetailViewController = segue.destination as? DetailViewController,
              let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        let movie: Movie = myTabBarController.movies[indexPath.row]
        detailViewController.movieId = movie.id
        detailViewController.movieTitle = movie.title
        
        // detail view controller 에서 back button 바꾸려면 까다롭다.
        let backBarButtonItem = UIBarButtonItem(title: "영화목록", style: .plain, target: self, action: nil)
        myTabBarController.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

