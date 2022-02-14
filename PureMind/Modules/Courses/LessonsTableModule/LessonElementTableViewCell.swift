//
//  LessonElementTableViewCell.swift
//  PureMind
//
//  Created by Клим on 06.02.2022.
//

import UIKit

class LessonElementTableViewCell: UITableViewCell {
    
    static let identifier = "lessonElementCell"
    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var elementIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
