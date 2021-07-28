//
//  ExpTitleViewCell.swift
//  PureMind
//
//  Created by Клим on 11.07.2021.
//

import UIKit
import ExpyTableView

class ExpTitleViewCell: UITableViewCell, ExpyTableViewHeaderCell {
    @IBOutlet weak var imageViewArrow: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ExpTitleViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 204, green: 212, blue: 251)
        layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
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
