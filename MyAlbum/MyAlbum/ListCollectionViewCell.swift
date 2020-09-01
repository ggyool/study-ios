//
//  ListCollectionViewCell.swift
//  MyAlbum
//
//  Created by ggyool on 2020/09/01.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            // 생성자 같은곳은 없는지
            self.layer.borderColor = CGColor(srgbRed: 0.8, green: 0.8, blue: 0.2, alpha: 0.7)
            self.layer.borderWidth = isSelected ? 5 : 0
        }
    }
    
}
