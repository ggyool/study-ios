//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/10.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movieId: String!
    // 꼭 전달받아야 하는지 (navigation item title 때문에 전달 받았다.)
    var movieTitle: String!
    var movieDetail: MovieDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movieTitle
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieDetailNotification(_:)) ,name: DidReceiveMovieDetailNotification, object: nil)
        requestMovieDetail(movieId: self.movieId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func didReceiveMovieDetailNotification(_ notification: Notification) {
        guard let movieDetail: MovieDetail = notification.userInfo?["movieDetail"] as? MovieDetail else {
            return
        }
    }
    



}
