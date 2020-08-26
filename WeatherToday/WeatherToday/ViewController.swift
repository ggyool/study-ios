//
//  ViewController.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/23.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var nations: [Nation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "세계 날씨"
        loadData()
    }
    
    func loadData(){
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "countries") else {
            return
        }
        do{
            nations = try jsonDecoder.decode([Nation].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nation = nations[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as? CustomTableViewCell_RootView else {
            preconditionFailure("cell 불러오기 실패")
        }
        cell.nationLabel.text = nation.koreanName
        cell.flagImageView.image = UIImage(named: "flag_" + nation.name)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? ListViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        nextViewController.nation = nations[indexPath.row]
    }

    /*
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print(indexPath.row)
        return indexPath
    }
     */
}

