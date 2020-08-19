//
//  BasicInfoViewController.swift
//  SignUp
//
//  Created by ggyool on 2020/08/17.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class BasicInfoViewController:UIViewController,
    UIImagePickerControllerDelegate ,UINavigationControllerDelegate,
    UIGestureRecognizerDelegate, UITextViewDelegate{

    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    var userDto: UserInformationDto?
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMember()
        addGesture()
        addAction()
    }
    
    func initMember(){
        nextButton.isEnabled = false
        userDto = UserInformationDto()
        introductionTextView.delegate = self
    }
    
    // 취소 버튼 눌렀을 때 로그인 화면으로 돌아가기
    @IBAction func touchCancelButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    // image picker 보여주기 (image view 클릭시)
    func presentImagePicker(){
        self.present(imagePicker, animated: true, completion: nil)
    }
    // image picker 에서 사진을 선택했을 때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = image
            let isButtonActive: Bool = checkValidation()
            changeNextButtonState(isButtonActive)
        }
        self.dismiss(animated: true, completion: nil)
    }
    // image picker 에서 취소를 눌렀을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // image view에 gesture 추가하기
    func addGesture(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.imageView.addGestureRecognizer(tapGesture)
    }
    
    // image view tap 했을시 동작
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        presentImagePicker()
        return true
    }
    
    // view 를 tap 했을시 동작
    @IBAction func touchView(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    func addAction(){
        idTextField.addTarget(self, action: #selector(editText(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(editText(_:)), for: UIControl.Event.editingChanged)
        checkPasswordTextField.addTarget(self, action: #selector(editText(_:)), for: UIControl.Event.editingChanged)
    }
    
    // text view 수정시 하는 동작
    func textViewDidChange(_ textView: UITextView) {
        let isButtonActive: Bool = checkValidation()
        changeNextButtonState(isButtonActive)
    }
    
    // 각각 text field 가 수정시 하는 동작
    @objc func editText(_ sender: UITextField){
        let isButtonActive: Bool = checkValidation()
        changeNextButtonState(isButtonActive)
    }

    // text field, textView 유효성 검사, dto 값 수정
    func checkValidation() -> Bool{
        guard let id = idTextField.text,
            let password = passwordTextField.text,
            let checkPassword = checkPasswordTextField.text,
            let introduction = introductionTextView.text else {
                return false
        }
        if id.isEmpty || password.isEmpty || checkPassword.isEmpty || introduction.isEmpty || imageView.image==nil {
            return false
        }
        if password != checkPassword {
            return false
        }
        changeDtoValue(id, password, introduction)
        return true
    }
    
    // validation에 따른 버튼 상태 변경
    func changeNextButtonState(_ isActive: Bool){
        nextButton.isEnabled = isActive
        if(isActive) {
            nextButton.setTitleColor(UIColor.systemTeal, for: UIControl.State.normal)
        }
        else {
            nextButton.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        }
    }
    
    // dto값 변경
    func changeDtoValue(_ id: String, _ password: String, _ introduction: String){
        guard let userDto = self.userDto else{
            return
        }
        userDto.id = id
        userDto.password = password
        userDto.intoroduction = introduction
    }
    
    // segue를 통해 id, password, introduction 정보가 들어있는 dto를 넘겨준다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "DetailSegue",
            let destination = segue.destination as? DetailInfoViewController{
                
            destination.userDto = userDto
        }
    }
}

//
//class ActionForTapView: UIViewController, UIGestureRecognizerDelegate{
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    func setGesture(imageView: UIImageView){
//        print("modi imageView:", imageView)
//        let tapGesture = UITapGestureRecognizer()
//        tapGesture.delegate = self
//        imageView.addGestureRecognizer(tapGesture)
//    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        print("!!!!!!")
//        return true
//    }
//}
