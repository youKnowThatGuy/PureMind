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
        self.backgroundColor = newButtonLabelColor
        self.layer.cornerRadius = 20
    }
    
    func selectedView(){
        self.backgroundColor = UIColor(patternImage: UIImage(named: "background13")!)
        label.textColor = newButtonLabelColor
    }
    
    func unselectedView(){
        self.backgroundColor = newButtonLabelColor
        label.textColor = .white
    }
    
}
