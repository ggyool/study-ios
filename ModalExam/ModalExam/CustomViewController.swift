//
//  CustomViewController.swift
//  ModalExam
//
//  Created by ggyool on 2020/08/13.
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
        customView.pushButton.addTarget(self, action: #selector(presentButtonPressed), for: UIControl.Event.touchUpInside)
        customView.popButton.addTarget(self, action: #selector(dismissButtonPressed), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
    }
    

    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    @objc func presentButtonPressed(_: UIButton){
        let nextViewController = CustomViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        print("presentButtonPressed func run next: ", nextViewController, "current: ", self)
        self.present(nextViewController, animated: true, completion: nil)
    }
    @objc func dismissButtonPressed(_: UIButton){
        print("dismissButtonPressed func run")
        self.dismiss(animated: true, completion: nil)
    }

}
