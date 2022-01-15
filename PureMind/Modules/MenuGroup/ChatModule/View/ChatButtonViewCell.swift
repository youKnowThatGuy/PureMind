//
//  ChatButtonViewCell.swift
//  PureMind
//
//  Created by Клим on 29.09.2021.
//

import UIKit

class ChatButtonViewCell: UICollectionViewCell {
    let label = UILabel()
        
    static let identifier = "ChatButton"
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        }
        
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        }
        
    func setupSubviews() {
        contentView.addSubview(label)
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 13)
        }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
        }
        
     func configure(with text: String) {
        label.text = text
        label.textColor = .white
        self.layer.cornerRadius = 15
        self.backgroundColor = lightYellowColor
    }
}
