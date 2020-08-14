//
//  ViewController.swift
//  DelegatePatternExam
//
//  Created by ggyool on 2020/08/15.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpSelectImageButton(_ sender: UIButton){
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imageView.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
    }
}

