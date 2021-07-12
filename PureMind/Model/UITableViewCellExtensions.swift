//
//  UITableViewCellExtensions.swift
//  PureMind
//
//  Created by Клим on 11.07.2021.
//

import UIKit

extension UITableViewCell {

    func showSeparator() {
        DispatchQueue.main.async {
            self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func hideSeparator() {
        DispatchQueue.main.async {
            self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
        }
    }
}
