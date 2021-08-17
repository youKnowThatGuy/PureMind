//
//  ShortPolicyViewCell.swift
//  PureMind
//
//  Created by Клим on 11.07.2021.
//

import UIKit

class ShortPolicyViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = "shortPolicyCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor(red: 204, green: 212, blue: 251).cgColor
        self.layer.borderWidth = 2
        layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
        descriptionLabel.textColor = grayTextColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
