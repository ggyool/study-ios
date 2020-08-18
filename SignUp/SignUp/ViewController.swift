//
//  ViewController.swift
//  SignUp
//
//  Created by ggyool on 2020/08/16.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !UserInformation.isEmpty(){
            idTextField.text = UserInformation.getId()
        }
        passwordTextField.text?.removeAll()        
    }
}

