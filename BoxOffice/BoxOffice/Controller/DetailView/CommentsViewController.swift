//
//  CommentsViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/13.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell  = tableView.dequeueReusableCell(withIdentifier: "CommentIdentifier", for: indexPath)
        return cell
    }

}
