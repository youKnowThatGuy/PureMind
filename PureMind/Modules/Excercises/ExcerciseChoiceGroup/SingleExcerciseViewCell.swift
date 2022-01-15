//
//  ExcerciseViewCell.swift
//  PureMind
//
//  Created by Клим on 15.01.2022.
//

import UIKit

class SingleExcerciseViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftColorView: UIView!
    
    static let identifier = "singleExcerciseViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 253, green: 247, blue: 221)
        titleLabel.textColor = UIColor(red: 251, green: 210, blue: 174)
        //titleLabel.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 251, green: 210, blue: 174), thickness: 1)
        leftColorView.backgroundColor =  UIColor(red: 251, green: 210, blue: 174)
        self.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    

}
