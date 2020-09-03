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
            if isSelected == false {
                self.layer.borderWidth = 0
            }
        }
    }
    
}
