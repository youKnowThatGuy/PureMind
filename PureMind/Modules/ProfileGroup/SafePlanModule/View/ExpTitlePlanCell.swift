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
    @IBOutlet weak var modifyLabel: UILabel!
    
    static let identifier = "ExpTitlePlanCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.layer.borderColor = newButtonLabelColor.cgColor
        self.layer.borderWidth = 1
        modifyLabel.textColor = .white
        modifyLabel.backgroundColor = newButtonLabelColor
        modifyLabel.layer.masksToBounds = true
        modifyLabel.layer.cornerRadius = 15
        titleLabel.textColor = newButtonLabelColor
        planLabel.textColor = newButtonLabelColor
        layer.cornerRadius = 20
        contentView.layer.cornerRadius = 20
    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            modifyLabel.isHidden = true
            hideSeparator()
                
        case .willCollapse:
            print("WILL COLLAPSE")
                
        case .didExpand:
            print("DID EXPAND")
                
        case .didCollapse:
            showSeparator()
            modifyLabel.isHidden = false
            print("DID COLLAPSE")
        }
    }
}
