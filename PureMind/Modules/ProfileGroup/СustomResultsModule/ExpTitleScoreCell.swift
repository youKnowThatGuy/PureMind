//
//  ExpTitleScoreCell.swift
//  PureMind
//
//  Created by Клим on 19.04.2022.
//

import UIKit
import ExpyTableView

class ExpTitleScoreCell: UITableViewCell, ExpyTableViewHeaderCell {
    
    @IBOutlet weak var imageViewArrow: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    static let identifier = "ExpTitleScoreCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = UIColor(red: 204, green: 212, blue: 251)
        self.titleLabel.textColor = grayTextColor
        self.scoreLabel.textColor = grayTextColor
        layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 204, green: 212, blue: 251).cgColor
    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
            
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            hideSeparator()
            arrowDown(animated: !cellReuse)
                
        case .willCollapse:
            print("WILL COLLAPSE")
            arrowUp(animated: !cellReuse)
                
        case .didExpand:
            print("DID EXPAND")
                
        case .didCollapse:
            showSeparator()
            print("DID COLLAPSE")
        }
    }
        
    private func arrowDown(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) {
            self.imageViewArrow.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
        }
    }
        
    private func arrowUp(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) {
            self.imageViewArrow.transform = CGAffineTransform(rotationAngle: (-CGFloat.pi * 2))
        }
    }
}
