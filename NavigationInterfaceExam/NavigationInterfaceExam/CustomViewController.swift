//
//  CustomViewController.swift
//  NavigationInterfaceExam
//
//  Created by ggyool on 2020/08/12.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    let customView: CustomView = {
        let view = CustomView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.pushButton.addTarget(self, action: #selector(pushButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        customView.popButton.addTarget(self, action: #selector(popButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
    }
    

    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    @objc func pushButtonPressed(_: UIButton){
        let nextViewController = CustomViewController()
        print("pushButtonPressed func run next: ", nextViewController, "current: ", self)
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    @objc func popButtonPressed(_: UIButton){
        print("popButtonPressed func run")
        navigationController?.popViewController(animated: true)
    }

}
