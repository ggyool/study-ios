//
//  CustomCommentsViewCell.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/14.
//

import UIKit

class CustomCommentsViewCell: UITableViewCell {

    
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet var starImageViews: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
