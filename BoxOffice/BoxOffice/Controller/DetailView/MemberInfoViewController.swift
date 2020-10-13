//
//  MemberInfoViewController.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/13.
//

import UIKit

class MemberInfoViewController: UIViewController {

    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadDate(actor: String, director: String) {
        directorLabel.text = director
        actorLabel.text = actor
        calculatePreferredSize()
    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }

}
