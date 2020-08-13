//
//  ViewController.swift
//  ViewExam
//
//  Created by ggyool on 2020/08/11.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let frame = CGRect(x: 60, y: 100, width: 240, height: 120)
        let subView = UIView(frame: frame)
        
        
        subView.backgroundColor = UIColor.green
        
        view.addSubview(subView)
    }


}

