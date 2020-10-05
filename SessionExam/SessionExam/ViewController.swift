//
//  ViewController.swift
//  SessionExam
//
//  Created by ggyool on 2020/09/16.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
     
    @IBOutlet weak var tableView: UITableView!
    let cellIndentifier: String = "friendCell"
    var friends: [Friend] = []
    
    
    // 1. back ground thread 에서 requestFriends 동작이 실행된다. (데이터 불러오는 메소드에서 다른 쓰레드로 넘어간다.)
    // 2. controller 에서 didReceiveFriendsNotification가 실행될 때도 같은 쓰레드에서 실행된다.
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveFriendsNotification(_:)),
                                               name: DidReceiveFriendsNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestFriends()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier, for: indexPath)
        let friend: Friend = self.friends[indexPath.row]
        
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
    
        cell.imageView?.image = nil
        
        // background queue 에서 동작시키고 싶은 경우
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else {
                return
            }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else {
                return
            }
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.imageView?.image = UIImage(data: imageData)
                        cell.setNeedsLayout() // 이것만 쓰면 다음 draw cycle에
                        cell.layoutIfNeeded() // 즉시 새로고침 하고 싶으면 씀
                    }
                }
            }
        }
        return cell
    }
    
    @objc func didReceiveFriendsNotification(_ noti: Notification) {
        guard let friends: [Friend] = noti.userInfo?["friends"] as? [Friend] else{
            return
        }
        self.friends = friends
//        DispatchQueue.main.async {
            self.tableView.reloadData()
//        }
        print("run func")
    }
}

    
