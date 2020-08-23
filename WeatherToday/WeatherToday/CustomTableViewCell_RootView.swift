//
//  CustomTableViewCell_RootView.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/23.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class CustomTableViewCell_RootView: UITableViewCell {

    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nationLabel: UILabel!
    var nationType: NationType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
