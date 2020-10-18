//
//  CommentWriteViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/16.
//

import UIKit

class CommentWriteViewController: UIViewController, UINavigationBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var starImageViews: [UIImageView]!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var writerTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    
    var movieId: String!
    var movieTitle: String!
    var movieGrade: GradeType!
    let normalBorderColor = UIColor.lightGray.cgColor
    let highlightBorderColor = CGColor(red: 0.2, green: 0.4, blue: 1.0, alpha: 0.7)
    
    
    // navigation bar를 직접 추가하니 notch 있는 몯레에서 status bar 부분에 navigation bar이 채워지지 않았다.
    // 그래서 delegate 추가하여 넣었더니 됨
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTextComponents()
        self.myNavigationBar.delegate = self
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureOnStar(_:)))
        starStackView.addGestureRecognizer(panGesture)
        
        titleLabel.text = self.movieTitle
        ageImageView.image = self.movieGrade.getImage()
    }
    
    
    func initTextComponents() {
        self.writerTextField.layer.borderColor = normalBorderColor
        self.writerTextField.layer.borderWidth = 1.0
        self.writerTextField.layer.cornerRadius = 5
        
        self.contentsTextView.layer.borderColor = normalBorderColor
        self.contentsTextView.layer.borderWidth = 1.0
        self.contentsTextView.layer.cornerRadius = 5
        self.contentsTextView.delegate = self
        setTextViewPlaceHolder(self.contentsTextView)
    }
    
    func hasPlaceHolder(_ textView: UITextView) -> Bool{
        return textView.textColor == UIColor.placeholderText
    }
    
    func setTextViewPlaceHolder(_ textView: UITextView) {
        let msg: String = "한줄평을 입력하세요"
        textView.textColor = UIColor.placeholderText
        textView.text = msg
    }
    
    func unsetTextViewPlaceHolder(_ textView: UITextView) {
        textView.textColor = UIColor.darkText
        textView.text = ""
    }

    @objc func panGestureOnStar(_ sender: UIPanGestureRecognizer){
        let score = self.getScore(sender.location(in: starStackView).x)
        fillStars(score)
        scoreLabel.text = "\(score)"
    }
    
    func getScore(_ locationX: CGFloat) -> Int {
        let starWidth = self.starImageViews[0].bounds.width
        // locationX는 몇 번째 별인지
        var idx: Int = 4
        for i in 0..<self.starImageViews.count {
            let criteria = starWidth * CGFloat(i+1)
            if(locationX <= criteria) {
                idx = i
                break
            }
        }
        var score = 2 * idx
        let left: CGFloat = starWidth * CGFloat(idx)
        // 이상이면 조건 만족
        let halfX = left + starWidth/3
        let fullX = left + starWidth/3 + starWidth/3
        if(locationX >= fullX) {
            score += 2
        }
        else if(locationX >= halfX) {
            score += 1
        }
        return score
    }

    func fillStars(_ score: Int) {
        // start 부터는 empty로 채울것임
        var start: Int = score/2
        for i in 0..<(score/2) {
            self.starImageViews[i].image = Common.fullStarImage
        }
        if(score%2==1) {
            self.starImageViews[score/2].image = Common.halfStarImage
            start += 1
        }
        for i in start..<self.starImageViews.count {
            self.starImageViews[i].image = Common.emptyStarImage
        }
    }
    
    @IBAction func touchUpCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSendButton(_ sender: Any) {
        guard let commentPostRequestDto: CommentPostRequestDto = self.makeCommentPostRequestDto() else {
            print("validation err")
            return
        }
        requestComment(commentPostRequestDto: commentPostRequestDto)
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkValidation() -> Bool {
        if(self.writerTextField.text!.isEmpty) {
            return false
        }
        if(self.contentsTextView.text.isEmpty || hasPlaceHolder(self.contentsTextView)) {
            return false
        }
        return true
    }
    
    func makeCommentPostRequestDto() -> CommentPostRequestDto? {
        if(checkValidation()==false) {
            return nil
        }
        guard let ratingText = self.scoreLabel.text,
              let writerText = self.writerTextField.text,
              let contentsText = self.contentsTextView.text else {
            return nil
        }
        let rating: Double = Double(ratingText) ?? 0.0
        return CommentPostRequestDto(rating: rating, writer: writerText, movieId: self.movieId, contents: contentsText)
    }
    
    @IBAction func touchView(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func textFieldEditingBegin(_ sender: Any) {
        self.writerTextField.layer.borderColor = highlightBorderColor
    }
    
    @IBAction func textFieldEditingEnd(_ sender: Any) {
        self.writerTextField.layer.borderColor = normalBorderColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.contentsTextView.layer.borderColor = highlightBorderColor
        if(hasPlaceHolder(self.contentsTextView)) {
            self.unsetTextViewPlaceHolder(self.contentsTextView)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.contentsTextView.layer.borderColor = normalBorderColor
        if(textView.text.isEmpty) {
            self.setTextViewPlaceHolder(self.contentsTextView)
        }
    }
    

    
}
