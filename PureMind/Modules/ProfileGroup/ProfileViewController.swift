//
//  ProfileViewController.swift
//  PureMind
//
//  Created by Клим on 17.08.2021.
//

import UIKit

protocol ProfileViewProtocol: UIViewController{
    func updateUI()
}

class ProfileViewController: UIViewController {
    var presenter: ProfilePresenterProtocol!
    
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func prepareTableView(){
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }

}

extension ProfileViewController: ProfileViewProtocol{
    func updateUI() {
        optionsTableView.reloadData()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 4:
            performSegue(withIdentifier: "policiesShortSegueSecond", sender: nil)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.optionsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewCell.identifier) as? ProfileViewCell
        else { fatalError("invalid cell kind")}
        presenter.prepareCell(cell: cell, index: indexPath.row)
        return cell
    }
}
