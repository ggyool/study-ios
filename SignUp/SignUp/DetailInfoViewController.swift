//
//  DetailInfoViewController.swift
//  SignUp
//
//  Created by ggyool on 2020/08/17.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    // Basic Controller 로 부터 넘겨받는 dto
    var userDto: UserInformationDto?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }()
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMember()
    }
    
    func initMember(){
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        joinButton.isEnabled = false
    }
    
    @IBAction func touchView(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func touchCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchPrevButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // phone text field 변경시 동작
    @IBAction func editPhoneText(_ sender: UITextField) {
        let isButtonActive: Bool = checkValidation()
        changeJoinButtonState(isButtonActive)
    }
    
    
    // date picker 변경시 label변경, dto 변경
    @IBAction func changeDatePickerValue(_ sender: UIDatePicker) {
        let birth = sender.date
        dateLabel.text = dateFormatter.string(from: birth)
        userDto?.birth = birth
        let isButtonActive: Bool = checkValidation()
        changeJoinButtonState(isButtonActive)
    }
    
    func checkValidation() -> Bool{
        guard let phone = phoneTextField.text else {
            return false
        }
        // phone validation
        let regex = "010\\d{7,8}$|010-\\d{3,4}-\\d{4}$"
        let regexTest = NSPredicate(format: "SELF MATCHES %@", regex)
        if(!regexTest.evaluate(with: phone)){
            return false
        }
        if datePicker.date.distance(to: Date()) <= 3600*24 {
            return false
        }
        return true
    }
    
    func changeJoinButtonState(_ isActive: Bool){
        joinButton.isEnabled = isActive
        if isActive {
            joinButton.setTitleColor(UIColor.systemTeal, for: UIControl.State.normal)
        }
        else {
            joinButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        }
    }
    
    // 가입 버튼
    @IBAction func touchJoinButton(_ sender: UIButton) {
        UserInformation.setValues(dto: userDto!)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
