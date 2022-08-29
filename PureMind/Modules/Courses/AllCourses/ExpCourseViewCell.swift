//
//  ExpCourseViewCell.swift
//  PureMind
//
//  Created by Клим on 16.01.2022.
//

import UIKit
import ExpyTableView

class ExpCourseViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "courseTitleCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.layer.borderColor = newButtonLabelColor.cgColor
        self.layer.borderWidth = 1
        titleLabel.textColor = newButtonLabelColor
        self.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
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
