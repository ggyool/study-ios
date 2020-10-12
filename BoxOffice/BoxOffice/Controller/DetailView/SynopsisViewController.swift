//
//  SynopsisViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/12.
//

import UIKit

class SynopsisViewController: UIViewController {

    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func reloadDate(synopsis: String) {
        synopsisLabel.text = synopsis+synopsis
        calculatePreferredSize()
    }

    private func calculatePreferredSize() {
        // 414,0 이 나온다 사실상 의미없다.
        let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }

        

}
