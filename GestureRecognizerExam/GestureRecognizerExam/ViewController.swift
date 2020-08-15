//
//  ViewController.swift
//  GestureRecognizerExam
//
//  Created by ggyool on 2020/08/16.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

//    @IBAction func tapView(_ sender: UITapGestureRecognizer){
//        self.view.endEditing(true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* 1. 코드로 생성하는 방식
        let tapGesture: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        self.view.addGestureRecognizer(tapGesture)
        */
        
        // 2. delegate 사용
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        // true false 상관 없음
        return true
    }


}

