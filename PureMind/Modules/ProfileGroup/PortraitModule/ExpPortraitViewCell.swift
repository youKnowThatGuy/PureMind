//
//  ExpPortraitViewCell.swift
//  PureMind
//
//  Created by Клим on 02.02.2022.
//

import UIKit
import ExpyTableView

class ExpPortraitViewCell: UITableViewCell {

    static let identifier = "portraitTitleCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = newButtonLabelColor.cgColor
        self.layer.borderWidth = 1
        titleLabel.textColor = newButtonLabelColor
        self.layer.cornerRadius = 25
        contentView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
            
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            hideSeparator()
                
        case .willCollapse:
            print("WILL COLLAPSE")
                
        case .didExpand:
            print("DID EXPAND")
                
        case .didCollapse:
            showSeparator()
            print("DID COLLAPSE")
        }
    }
}
