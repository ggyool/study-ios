//
//  CustomTableViewCell.swift
//  BoxOffice
//
//  Created by ggyool on 2020/10/04.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var ageImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var ratingLable: UILabel!
    @IBOutlet weak var rankingLable: UILabel!
    @IBOutlet weak var bookingRateLable: UILabel!
    @IBOutlet weak var releaseDateLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // padding 넣는 방법
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }

}
