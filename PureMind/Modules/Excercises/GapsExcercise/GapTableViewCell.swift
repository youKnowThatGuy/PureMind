//
//  GapTableViewCell.swift
//  PureMind
//
//  Created by Клим on 13.10.2021.
//

import UIKit

class GapTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "gapCell"
    var index: Int!
    var parentPresenter: GapsExcercisePresenterProtocol!

    @IBOutlet weak var textPartLabel: UILabel!
    
    @IBOutlet weak var answerField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 25 - 1, width: 300, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 238, green: 245, blue: 255).cgColor
        answerField.borderStyle = UITextField.BorderStyle.none
        textPartLabel.textColor = grayTextColor
        answerField.textColor = grayTextColor
        answerField.layer.addSublayer(bottomLine)
    }
 
    func textFieldDidEndEditing(_ textField: UITextField) {
        parentPresenter.updateAnswers(answer: textField.text ?? "", cellIndex: index)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
