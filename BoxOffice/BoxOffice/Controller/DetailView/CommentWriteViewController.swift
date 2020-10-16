//
//  CommentWriteViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/16.
//

import UIKit

class CommentWriteViewController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    
    // navigation bar를 직접 추가하니 notch 있는 몯레에서 status bar 부분에 navigation bar이 채워지지 않았다.
    // 그래서 delegate 추가하여 넣었더니 됨
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myNavigationBar.delegate = self
    }

}
