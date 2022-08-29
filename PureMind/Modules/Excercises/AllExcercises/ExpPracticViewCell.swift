//
//  ExpPracticViewCell.swift
//  PureMind
//
//  Created by Клим on 03.01.2022.
//

import UIKit
import ExpyTableView

class ExpPracticViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftColorView: UIView!
    
    static let identifier = "practicTitleCell"
    var stageCell = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if stageCell == false{
            self.backgroundColor = .clear
            titleLabel.textColor = newButtonLabelColor
            //titleLabel.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 251, green: 210, blue: 174), thickness: 1)
            self.layer.borderColor = newButtonLabelColor.cgColor
            self.layer.borderWidth = 1
        }
        else{
            self.backgroundColor = UIColor(red: 254, green: 250, blue: 234)
            titleLabel.textColor = UIColor(red: 254, green: 146, blue: 62)
            //titleLabel.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 251, green: 210, blue: 174), thickness: 1)
            leftColorView.backgroundColor =  lightYellowColor
        }
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
