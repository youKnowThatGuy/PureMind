//
//  ThemeViewCell.swift
//  PureMind
//
//  Created by Клим on 30.07.2021.
//

import UIKit

class ThemeViewCell: UICollectionViewCell {
    
    static let identifier = "ThemeViewCell"
    
    var themeNotChosen = true
    
    @IBOutlet weak var themeNameLabel: UILabel!
    
    @IBOutlet weak var checkBoxLabel: UIImageView!
    
}
