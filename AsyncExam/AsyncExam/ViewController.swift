//
//  ViewController.swift
//  AsyncExam
//
//  Created by ggyool on 2020/08/28.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        let strURL: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/LARGE_elevation.jpg/1600px-LARGE_elevation.jpg"
        OperationQueue().addOperation {
            guard let imageURL: URL = URL(string: strURL),
                let imageData: Data = try? Data(contentsOf: imageURL),
                let image: UIImage = UIImage(data: imageData) else {
                return
            }
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

