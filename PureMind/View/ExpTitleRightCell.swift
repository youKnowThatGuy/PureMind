//
//  ExpTitleRightCell.swift
//  PureMind
//
//  Created by Клим on 12.07.2021.
//

import UIKit
import ExpyTableView

class ExpTitleRightCell: UITableViewCell, ExpyTableViewHeaderCell {
    @IBOutlet weak var imageViewArrow: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ExpTitleRightCell"
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
            
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            hideSeparator()
            arrowDown(animated: !cellReuse)
                
        case .willCollapse:
            print("WILL COLLAPSE")
            arrowRight(animated: !cellReuse)
                
        case .didExpand:
            print("DID EXPAND")
                
        case .didCollapse:
            showSeparator()
            print("DID COLLAPSE")
        }
    }
        
    private func arrowDown(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) {
            self.imageViewArrow.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        }
    }
        
    private func arrowRight(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) {
            self.imageViewArrow.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
}
