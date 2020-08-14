//
//  MeetingRoomTableViewController.swift
//  MeetingRooms
//
//  Created by ggyool on 2020/08/14.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class MeetingRoomTableViewController: UITableViewController {
    // 문자열:딕셔너리
    var meetingRooms: [String: [String: Int]] = [
        "Meeting": ["A":3, "B":4,"C":5,"D":4,"E":3],
        "Seminar": ["SA":30, "SB":40,"SC":50,"SD":40]
    ]
    func meetingRoomsAtIndex(_ index: Int) -> (key: String, value: [String: Int]) {
        let orderedMeetingRooms = meetingRooms.sorted{
            $0.1.first!.1 < $1.1.first!.1
        }
        return orderedMeetingRooms[index]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meetingRooms.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // let categoryValues = Array(meetingRooms.values)[section]
        // .1 = value
        // tuple
        let rowCount = meetingRoomsAtIndex(section).value.count
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
//        // dictionary
//        let categoryValues = Array(meetingRooms.values)[indexPath.section]
//        // key array

        
        
        let categoryValues = meetingRoomsAtIndex(indexPath.section).value
        let orderedCategoryValues = categoryValues.sorted{$0.1 < $1.1}
        let roomName = orderedCategoryValues[indexPath.row].0
        let capacity = orderedCategoryValues[indexPath.row].1
        cell.textLabel!.text = roomName
        cell.detailTextLabel!.text = "\(capacity)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meetingRoomsAtIndex(section).key
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let rowCount = meetingRoomsAtIndex(section).value.count
        return "\(rowCount) rooms"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
