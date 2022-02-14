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
    @IBOutlet weak var leftColorView: UIView!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    static let identifier = "courseTitleCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 253, green: 247, blue: 221)
        titleLabel.textColor = UIColor(red: 211, green: 228, blue: 160)
        titleLabel.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 211, green: 228, blue: 160), thickness: 1)
        leftColorView.backgroundColor =  UIColor(red: 211, green: 228, blue: 160)
        descriptionLabel.textColor = grayTextColor
        self.layer.cornerRadius = 15
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
