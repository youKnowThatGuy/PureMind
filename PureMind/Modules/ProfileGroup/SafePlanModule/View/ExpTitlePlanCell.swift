//
//  ExpTitlePlanCell.swift
//  PureMind
//
//  Created by Клим on 25.02.2022.
//

import UIKit
import ExpyTableView

class ExpTitlePlanCell: UITableViewCell, ExpyTableViewHeaderCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
    
    static let identifier = "ExpTitlePlanCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = titleBlueColor
        planLabel.textColor = textFieldColor
        self.backgroundColor = titleBlueColor.withAlphaComponent(0.24)
        layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            noteImageView.isHidden = true
            hideSeparator()
                
        case .willCollapse:
            print("WILL COLLAPSE")
                
        case .didExpand:
            print("DID EXPAND")
                
        case .didCollapse:
            showSeparator()
            noteImageView.isHidden = false
            print("DID COLLAPSE")
        }
    }
}
