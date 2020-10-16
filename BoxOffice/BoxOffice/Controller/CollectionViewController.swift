//
//  ViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/04.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var collectionView: UICollectionView!
    weak var myTabBarController: TabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTabBarController = self.parent?.parent as? TabBarController
        self.navigationItem.rightBarButtonItem?.target = self.myTabBarController
        self.navigationItem.rightBarButtonItem?.action = #selector(self.myTabBarController.touchUpOrderButton(_:))
        configureRefreshController()
    }
    
    func configureRefreshController() {
        let refreshController: UIRefreshControl = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(pullDownCollectionView), for: .valueChanged)
        self.collectionView.refreshControl = refreshController
    }
    
    @objc func pullDownCollectionView() {
        requestMovies(myTabBarController.orderType)
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func refreshNavigationItem(_ orderType: OrderType) {
        self.navigationItem.title = orderType.getNavigationTitleString()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myTabBarController.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CustomCollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionIdentifier", for: indexPath) as? CustomCollectionViewCell else {
            preconditionFailure("콜렉션셀 불러오기 실패")
        }
        print("collection refresh")
        let movie: Movie = myTabBarController.movies[indexPath.item]
        cell.titleLabel.text = movie.title
        cell.rankingLabel.text = "\(movie.reservationGrade)위"
        cell.ratingLabel.text = String(movie.userRating)
        cell.bookingRateLabel.text = "\(movie.reservationRate)%"
        cell.releaseDateLabel.text = movie.dateString
        cell.ageImageView.image = movie.grade.getImage()
    
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { preconditionFailure("thumbnail url 문제") }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { preconditionFailure("thumbnail image 불러오기 실패") }
            DispatchQueue.main.async {
                cell.thumbImageView.image = UIImage(data: imageData)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth: CGFloat = view.bounds.width
        let itemSpacing: CGFloat = viewWidth * 0.03
        let edgeMargin: CGFloat = viewWidth * 0.03
        let itemCountPerLine: CGFloat = 2
        let spacingCountPerLine: CGFloat = itemCountPerLine - 1
        let cellWidth: CGFloat = (viewWidth - itemSpacing * spacingCountPerLine - 2*edgeMargin) / itemCountPerLine
        // 정해주지 않고 content 크기에 맞춰지는 방법은 없나
        let cellHeight: CGFloat = cellWidth * 1.9
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let viewWidth: CGFloat = view.bounds.width
        let edgeMargin = viewWidth * 0.03
        return UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: edgeMargin, right: edgeMargin)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let viewWidth: CGFloat = view.bounds.width
        let itemSpacing: CGFloat = viewWidth * 0.03
        return itemSpacing * 0.8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let viewWidth: CGFloat = view.bounds.width
        let itemSpacing: CGFloat = viewWidth * 0.03
        return itemSpacing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController: DetailViewController = segue.destination as? DetailViewController,
              let indexPath = self.collectionView.indexPathsForSelectedItems?[0] else {
            return
        }
        let movie: Movie = myTabBarController.movies[indexPath.row]
        detailViewController.movieId = movie.id
        detailViewController.movieTitle = movie.title
        let backBarButtonItem = UIBarButtonItem(title: "영화목록", style: .plain, target: self, action: nil)
        myTabBarController.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

