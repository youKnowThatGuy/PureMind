//
//  SafePlanTableViewCell.swift
//  PureMind
//
//  Created by Клим on 25.02.2022.
//

import UIKit

class SafePlanTableViewCell: UITableViewCell {
    
    static let identifier = "SafePlanTableViewCell"

    @IBOutlet weak var planTextView: UITextView!
    @IBOutlet weak var saveButtonShell: UIButton!
    var parentPresenter: SafePlanPresenterProtocol!
    var cellIndex: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor(red: 144, green: 191, blue: 255).cgColor
        self.layer.borderWidth = 1
        layer.cornerRadius = 15
        contentView.layer.cornerRadius = 15
        planTextView.backgroundColor = titleBlueColor.withAlphaComponent(0.45)
        planTextView.layer.cornerRadius = 15
        saveButtonShell.backgroundColor = lightYellowColor
        saveButtonShell.layer.cornerRadius = 15
        planTextView.addDoneButton(title: "Готово", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.endEditing(true)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        parentPresenter.insertPlan(str: planTextView.text, index: cellIndex)
    }
}
