//
//  CommentsViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/13.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var commentWriteButton: UIButton!
    
    var comments: [Comment] = []
    var movieId: String!
    var movieTitle: String!
    var movieGrade: GradeType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCommentsNotification(_:)), name: DidReceiveCommentsNotification, object: nil)
        self.tableView.isScrollEnabled = false
        // 넣으면 넉넉하게 잡았다가 알아서 처리해주는 듯
        self.tableView.estimatedRowHeight = 200.0;
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(self.tableView.contentSize.height > 0) {
            preferredContentSize =
                CGSize(width: self.tableView.contentSize.width, height: self.tableView.contentSize.height + self.headerView.bounds.height)
        }
    }
    
    
    func reloadData(movieId: String, title: String, grade: GradeType){
        requestComments(movieId: movieId)
        self.movieId = movieId
        self.movieTitle = title
        self.movieGrade = grade
        
    }
    
    @objc func didReceiveCommentsNotification(_ notification: Notification) {
        guard let comments: [Comment] = notification.userInfo?["comments"] as? [Comment] else {
            return
        }
        self.comments = comments
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomCommentsViewCell  =
                tableView.dequeueReusableCell(withIdentifier: "CommentIdentifier", for: indexPath) as? CustomCommentsViewCell else {
            preconditionFailure("테이블셀 불러오기 실패")
        }
        let comment: Comment = self.comments[indexPath.row]
        cell.writerLabel.text = comment.writer
        cell.timeLabel.text = Common.commentDateFormatter.string(from: Date(timeIntervalSince1970: comment.timestamp))
        cell.contentsLabel.text = comment.contents
//        cell.contentsLabel.text = "정말 다섯 번은 넘게 운듯 ᅲᅲᅲ 감동 쩔어요.꼭 보셈 두 번 보셈"
        self.fillStars(comment.rating.rounded(), cell)
        return cell
    }
    
    func fillStars(_ roundedRating: Double, _ cell: CustomCommentsViewCell) {
        let score: Int = Int(roundedRating)
        for i in 0..<(score/2) {
            cell.starImageViews[i].image = Common.fullStarImage
        }
        if(score%2==1) {
            cell.starImageViews[score/2].image = Common.halfStarImage
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let commentWriteViewController: CommentWriteViewController = segue.destination as? CommentWriteViewController else {
            return
        }
        commentWriteViewController.movieId = self.movieId
        commentWriteViewController.movieTitle = self.movieTitle
        commentWriteViewController.movieGrade = self.movieGrade
    }
}
