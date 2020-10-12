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
    @IBOutlet weak var synopsisView: UIView!
    @IBOutlet weak var synopsisHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieInfoHeightConstraint: NSLayoutConstraint!
    
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
         
        guard let movieInfoViewController: MovieInfoViewController = children[0] as? MovieInfoViewController else { return }
        movieInfoViewController.reloadData(movieDetail: movieDetail)
        
        guard let synopsisViewController: SynopsisViewController = children[1] as? SynopsisViewController else { return }
        synopsisViewController.reloadDate(synopsis: movieDetail.synopsis)
    }
    
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if (container as? SynopsisViewController) != nil {
            synopsisHeightConstraint.constant = container.preferredContentSize.height
        }
        if (container as? MovieInfoViewController) != nil {
            movieInfoHeightConstraint.constant = container.preferredContentSize.height
        }
        
    }


}
