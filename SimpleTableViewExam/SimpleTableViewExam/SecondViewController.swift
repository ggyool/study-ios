//
//  SecondViewController.swift
//  SimpleTableViewExam
//
//  Created by ggyool on 2020/08/22.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var textToSet: String?
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textLabel.text = textToSet
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
