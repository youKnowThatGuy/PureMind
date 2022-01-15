//
//  ButtonCollectionViewCell.swift
//  PureMind
//
//  Created by Клим on 06.11.2021.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ButtonChatCell"
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textColor = .white
        self.backgroundColor = UIColor(red: 144, green: 191, blue: 255)
        self.layer.cornerRadius = 20
    }
    
    func selectedView(){
        self.backgroundColor = lightYellowColor
        label.textColor = .white
    }
    
    func unselectedView(){
        self.backgroundColor = UIColor(red: 233, green: 241, blue: 254)
        label.textColor = grayTextColor
    }
    
}
