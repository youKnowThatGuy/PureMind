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
    @IBOutlet weak var policyImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
