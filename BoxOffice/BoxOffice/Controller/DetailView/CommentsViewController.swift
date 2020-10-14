//
//  CommentsViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/13.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wrapperView: UIView!
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCommentsNotification(_:)), name: DidReceiveCommentsNotification, object: nil)
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 이곳에서 reload 끝난 후 실행
        if(self.tableView.contentSize.height > 0) {
            preferredContentSize = self.tableView.contentSize
        }
    }
    
    func reloadData(movieId: String){
        requestComments(movieId: movieId)
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
        cell.contentsLabel.text = comment.contents
        
        return cell
    }

}
