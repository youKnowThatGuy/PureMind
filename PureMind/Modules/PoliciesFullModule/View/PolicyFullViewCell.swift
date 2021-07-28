//
//  PolicyFullViewCell.swift
//  PureMind
//
//  Created by Клим on 12.07.2021.
//

import UIKit

class PolicyFullViewCell: UITableViewCell {

    static let identifier = "policyFullCell"
    
    @IBOutlet weak var policyTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        policyTitleLabel.textColor = grayTextColor
        descriptionLabel.textColor = grayTextColor
        self.contentView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
