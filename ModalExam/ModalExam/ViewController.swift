//
//  ViewController.swift
//  ModalExam
//
//  Created by ggyool on 2020/08/13.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func presentButton(){
        let newVC = CustomViewController()
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true, completion: nil)
    }


}

