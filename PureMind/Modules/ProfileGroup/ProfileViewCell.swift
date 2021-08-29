//
//  ProfileViewCell.swift
//  PureMind
//
//  Created by Клим on 17.08.2021.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    static let identifier = "ProfileCell"
    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var optionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
