//
//  ViewController.swift
//  DatePickerExam
//
//  Created by ggyool on 2020/08/16.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        return formatter
    }()
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        self.dateLabel.text = dateString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
    }


}

