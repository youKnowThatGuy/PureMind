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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
