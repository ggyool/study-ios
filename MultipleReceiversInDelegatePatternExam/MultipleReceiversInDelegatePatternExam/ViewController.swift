//
//  ViewController.swift
//  MultipleReceiversInDelegatePatternExam
//
//  Created by ggyool on 2020/08/19.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageViewA: UIImageView!
    @IBOutlet weak var imageViewB: UIImageView!
    @IBOutlet weak var imageViewC: UIImageView!
    
    var controller_imageViewB: TapGestureForImageView?
    var controller_imageViewC: TapGestureForImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // code for imageViewA
        let gestureA = UITapGestureRecognizer()
        gestureA.delegate = self
        self.imageViewA.addGestureRecognizer(gestureA)
        
        // code for imageViewB, C
        controller_imageViewB = TapGestureForImageView(imageView: imageViewB, imageViewName: "B")
        controller_imageViewC = TapGestureForImageView(imageView: imageViewC, imageViewName: "C")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("tap A")
        return true
    }
}


// imageView들의 tap 동작을 위한 클래스
class TapGestureForImageView: UIViewController, UIGestureRecognizerDelegate {
    var name: String
    init(imageView: UIImageView, imageViewName: String){
        self.name = imageViewName
        super.init(nibName: nil, bundle: nil)
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        imageView.addGestureRecognizer(tapGesture)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("tap", self.name)
        return true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

