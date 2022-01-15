//
//  ExcercisesViewCell.swift
//  PureMind
//
//  Created by Клим on 04.01.2022.
//

import UIKit

class ExcercisesViewCell: UITableViewCell {
    static let identifier = "excercisesListCell"
    
    @IBOutlet weak var excercisesTableView: UITableView!
    
    var excercises = [PracticesInfo]()
    weak var parentVC: AllExcerciseViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        excercisesTableView.delegate = self
        excercisesTableView.dataSource = self
        excercisesTableView.separatorStyle = .none
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 251, green: 210, blue: 174).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ExcercisesViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        excercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExcerciseViewCell.identifier) as! ExcerciseViewCell
        cell.excerciseNameLabel.text = excercises[indexPath.row].name
        cell.backgroundImageView?.image = UIImage(named: "Rectangle 60")
        cell.emblemView.image = UIImage(named: "тик")
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let excercise = excercises[indexPath.row]
        parentVC?.practicChosen(id: excercise.id, title: excercise.category, name: excercise.name)
    }
}
