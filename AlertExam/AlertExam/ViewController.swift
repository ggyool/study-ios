//
//  ViewController.swift
//  AlertExam
//
//  Created by ggyool on 2020/09/15.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpShowAlertButton(_ sender: UIButton) {
        self.showAlertController(style: UIAlertController.Style.alert)
    }
    
    @IBAction func touchUpShowActionSheet(_ sender: UIButton) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func showAlertController(style: UIAlertController.Style) {
        let alertController: UIAlertController =
            UIAlertController(title: "Title", message: "Message", preferredStyle: style)
        
        let okAction: UIAlertAction =
            UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                action in
                print("OK Pressed")
            })
        
        alertController.addAction(okAction)
        
        let handler: (UIAlertAction) -> Void = {
            (action: UIAlertAction) in
            print("action pressed \(action.title ?? "")")
        }
        
        let someAction: UIAlertAction =
            UIAlertAction(title: "Some", style: UIAlertAction.Style.destructive, handler: handler)
        
        // cancel 은 한개만 넣을 수 있다.
        let anotherAction: UIAlertAction =
            UIAlertAction(title: "Another", style: UIAlertAction.Style.cancel, handler: handler)
        
        alertController.addAction(someAction)
        alertController.addAction(anotherAction)
        
        // text field 는 alert 에서만 사용 가능
        alertController.addTextField(configurationHandler: {
            (field: UITextField) in
            field.placeholder = "place holder"
            field.textColor = UIColor.cyan
            field.addTarget(self, action: #selector(self.textFieldEditiongEnd(_:)), for: UIControl.Event.editingDidEnd)
        })
        
        self.present(alertController, animated: true, completion: {
            print("alertController shown")
        })
    }
    
    @objc func textFieldEditiongEnd(_ sender: UITextField){
        print(sender.text!)
    }
}

