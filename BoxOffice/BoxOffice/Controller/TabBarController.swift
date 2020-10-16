//
//  TabBarController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/09.
//

import UIKit

class TabBarController: UITabBarController {
    
    var orderType = OrderType.reservationRate
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMoviesNotification(_:)), name: DidReceiveMoviesNotification, object: nil)
        requestMovies(self.orderType)
    }
    
    
    @objc func didReceiveMoviesNotification(_ notification: Notification) {
        guard let movies: [Movie] = notification.userInfo?["movies"] as? [Movie] else {
            return
        }
        guard let orderType: OrderType = notification.userInfo?["orderType"] as? OrderType else {
            return
        }
        self.orderType = orderType
        self.movies = movies

        
        print(self.navigationItem)
        self.navigationController?.title = orderType.getNavigationTitleString()
        
        // 뒤에 숨어있는 컨트롤러 relodDate를 해도 reload되지 않고 화면 전환시 reload 되는것을 확인한 후
        // 둘 다 새로고침 하면 좋을 것 같아서 이렇게 함
        // 처음 로드시 collectionView reload하면 nil 이라 에러가 난다. optional 사용했다.
        
        let tableViewController: TableViewController = self.children[0].children[0] as! TableViewController
        let collectionViewController: CollectionViewController = self.children[1].children[0] as! CollectionViewController
        tableViewController.tableView?.reloadData()
        tableViewController.refreshNavigationItem(orderType)
        collectionViewController.collectionView?.reloadData()
        collectionViewController.refreshNavigationItem(orderType)
    }
    
    @objc func touchUpOrderButton(_ sender: Any) {
        self.present(Common.alertController, animated: true, completion: nil)
    }
    
}
