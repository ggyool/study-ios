//
//  RootViewController.swift
//  NavigationInterfaceExam
//
//  Created by ggyool on 2020/08/12.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    let rootView: RootView = {
        let view = RootView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad: ", self)
        rootView.pushButton.addTarget(self, action: #selector(pushButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
    }
    
    @objc func pushButtonPressed(_: UIButton){
        let nextViewController = CustomViewController()
        print("pushButtonPressed func run next: ", nextViewController, "current: ", self)
        navigationController?.pushViewController(nextViewController, animated: true)
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
