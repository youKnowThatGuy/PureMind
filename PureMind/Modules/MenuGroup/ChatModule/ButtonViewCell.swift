//
//  ButtonViewCell.swift
//  PureMind
//
//  Created by Клим on 30.09.2021.
//

import UIKit

class ButtonViewCell: UITableViewCell {
    
    static let identifier = "ButtonCell"
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textColor = grayTextColor
        self.backgroundColor = UIColor(red: 233, green: 241, blue: 254)
        self.layer.cornerRadius = 15
        self.selectionStyle = .none
    }
    
    func selectedView(){
        self.backgroundColor = lightYellowColor
        label.textColor = .white
    }
    
    func unselectedView(){
        self.backgroundColor = UIColor(red: 233, green: 241, blue: 254)
        label.textColor = grayTextColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
