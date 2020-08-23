//
//  ViewController.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/23.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let nationTypess: [NationType] = [.kr, .de, .it, .us, .fr, .jp]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "세계 날씨"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nationTypess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nationType = nationTypess[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as? CustomTableViewCell_RootView else {
            preconditionFailure("cell 불러오기 실패")
        }
        cell.nationType = nationType
        cell.nationLabel.text = nationType.toKorean()
        cell.flagImageView.image = UIImage(named: "flag_" + nationType.rawValue)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? ListViewController,
            let tableViewCell = sender as? CustomTableViewCell_RootView else {
            return
        }
        nextViewController.nationType = tableViewCell.nationType
    }

}

