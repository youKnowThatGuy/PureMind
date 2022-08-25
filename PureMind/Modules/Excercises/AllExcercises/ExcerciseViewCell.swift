//
//  ExcerciseViewCell.swift
//  PureMind
//
//  Created by Клим on 04.01.2022.
//

import UIKit

class ExcerciseViewCell: UITableViewCell {
    
    static let identifier = "singleExcCell"
    @IBOutlet weak var excerciseNameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var emblemView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        excerciseNameLabel.textColor = newButtonLabelColor
        self.backgroundColor = .clear
        self.layer.borderColor = newButtonLabelColor.cgColor
        self.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
