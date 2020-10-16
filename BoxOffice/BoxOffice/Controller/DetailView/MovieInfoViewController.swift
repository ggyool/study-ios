//
//  MovieInfoViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/11.
//

import UIKit

class MovieInfoViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var ageImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var bookingRateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    
    
    @IBOutlet var starImageViews: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
    
    func reloadData(movieDetail: MovieDetail?){
        guard let movieDetail: MovieDetail = movieDetail else { return }
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movieDetail.image) else { preconditionFailure("thumbnail url 문제") }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { preconditionFailure("thumbnail image 불러오기 실패") }
        
            DispatchQueue.main.async {
                self.thumbImageView.image = UIImage(data: imageData)
                self.thumbImageView.setNeedsLayout()
                self.thumbImageView.layoutIfNeeded()
            }
        }
        fillStars(movieDetail.userRating.rounded())
        ageImageView.image = movieDetail.grade.getImage()
        titleLabel.text = movieDetail.title
        releaseDateLabel.text = movieDetail.dateString + " 개봉"
        genreLabel.text = movieDetail.genre
        playTimeLabel.text = "\(movieDetail.duration)분"
        rankingLabel.text = "\(movieDetail.reservationGrade)위"
        bookingRateLabel.text = "\(movieDetail.reservationRate)%"
        ratingLabel.text = "\(movieDetail.userRating)"
        audienceLabel.text = Common.numberFormatter.string(from: NSNumber(value: movieDetail.audience))
    }
    
    func fillStars(_ roundedRating: Double) {
        let score: Int = Int(roundedRating)
        for i in 0..<(score/2) {
            starImageViews[i].image = Common.fullStarImage
        }
        if(score%2==1) {
            starImageViews[score/2].image = Common.halfStarImage
        }
    }
}
