//
//  ViewController.swift
//  SingletonPatternExam
//
//  Created by ggyool on 2020/08/15.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    
    
    
    @IBAction func touchUpSetButton(_ sender: Any) {
        UserInformation.shared.name = nameField.text
        UserInformation.shared.age = ageField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

