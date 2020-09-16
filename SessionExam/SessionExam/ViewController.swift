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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        print("did appear")
        super.viewDidAppear(animated)
        guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else {
            return
        }
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.friends = apiResponse.results
                // 현재 실행되는 handler 는 메인쓰레드에서 동작하는 함수가 아님
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier, for: indexPath)
        let friend: Friend = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        
        guard let imageURL: URL = URL(string: friend.picture.thumbnail) else {
            return cell
        }
        guard let imageData: Data = try? Data(contentsOf: imageURL) else {
            return cell
        }
        cell.imageView?.image = UIImage(data: imageData)
        return cell
    }
}

    
