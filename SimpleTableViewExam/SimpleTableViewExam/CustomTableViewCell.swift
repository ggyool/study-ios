//
//  CustomTableViewCell.swift
//  SimpleTableViewExam
//
//  Created by ggyool on 2020/08/21.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var leftLabal: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
