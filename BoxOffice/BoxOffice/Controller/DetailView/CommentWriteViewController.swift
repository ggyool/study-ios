//
//  CommentWriteViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/16.
//

import UIKit

class CommentWriteViewController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    var movieTitle: String!
    var movieGrade: GradeType!
    
    var starIndexTable: [UIPanGestureRecognizer : Int] = [:]
    @IBOutlet var starImageViews: [UIImageView]!
    @IBOutlet weak var starStackView: UIStackView!
    
    // navigation bar를 직접 추가하니 notch 있는 몯레에서 status bar 부분에 navigation bar이 채워지지 않았다.
    // 그래서 delegate 추가하여 넣었더니 됨
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myNavigationBar.delegate = self
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureOnStar(_:)))
        starStackView.addGestureRecognizer(panGesture)
        for i in 0..<self.starImageViews.count {
            let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureOnStar(_:)))
            starImageViews[i].addGestureRecognizer(panGesture)
            starIndexTable[panGesture] = i
        }
    }

    @objc func panGestureOnStar(_ sender: UIPanGestureRecognizer){
        let i: Int = starIndexTable[sender] ?? 0
        let starImageView: UIImageView = self.starImageViews[i]
        let starWidth = starImageView.bounds.width
        let panX = sender.location(in: starImageView).x
        
        // 이상이면 조건 만족
        let halfX = starWidth/3
        let fullX = starWidth/3 + starWidth/3
        
        var score: Int = 2*i
        if(panX >= fullX) {
            score += 2
        }
        else if(panX >= halfX) {
            score += 1
        }
        fillStars(score)
    }

    func fillStars(_ score: Int) {
        for i in 0..<(score/2) {
            self.starImageViews[i].image = Common.fullStarImage
        }
        if(score%2==1) {
            self.starImageViews[score/2].image = Common.halfStarImage
        }
    }
    
    @IBAction func touchUpCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSendButton(_ sender: Any) {
        // comment post
    }
}
