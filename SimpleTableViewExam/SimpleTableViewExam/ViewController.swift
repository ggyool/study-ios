//
//  ViewController.swift
//  SimpleTableViewExam
//
//  Created by ggyool on 2020/08/21.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    let customCellIdentifier: String = "customCell"
    
    let korean: [String] = ["가","나","다","라","마","바","사","아","자","차","카","타","파","하"]
    let english: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N",
                             "O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var dates: [Date] = []
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    // 두 메소드는 required
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section<2{
            // 재사용 하지 않을 수도 있지만 낭비
            // let cell: UITableViewCell = UITableViewCell()
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            cell.textLabel?.text = text
            // 2번째 행만 빨강색으로 바꾸고 싶으면
            // 아닌 것들은 흰색으로 바꿔야 한다. (셀이 재사용 되기 때문에)
            if indexPath.row == 1{
                cell.backgroundColor = UIColor.red
            }
            else{
                cell.backgroundColor = UIColor.white
            }
            return cell
        }
        
        guard let customCell: CustomTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: self.customCellIdentifier, for: indexPath) as? CustomTableViewCell else {
                preconditionFailure("실패")
        }
        customCell.leftLabal.text = dateFormatter.string(from: dates[indexPath.row])
        customCell.rightLabel.text = timeFormatter.string(from: dates[indexPath.row])
        return customCell
    }
    
    // default 1
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section<2{
            return section == 0 ? "한글" : "영어"
        }
        return "시간"
    }
    
    // 버튼 눌르면 동적으로 데이터 추가
    @IBAction func touchUpAddButton(_ sender: UIButton) {
        dates.append(Date())
        // 전체 reload (비효율)
        // self.tableView.reloadData()
        self.tableView.reloadSections(IndexSet(2...2), with:UITableView.RowAnimation.automatic)
    }
    
    
    // 세그를 통해 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue가 여러개이면 indentifier 나 타입으로 구분해서 사용해야한다.
        guard let nextViewController: SecondViewController =
            segue.destination as? SecondViewController else {
            return
        }
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        nextViewController.textToSet = cell.textLabel?.text
    }
    
}

