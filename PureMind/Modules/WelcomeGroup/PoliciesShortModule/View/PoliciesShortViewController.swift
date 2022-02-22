//
//  PoliciesShortViewController.swift
//  PureMind
//
//  Created by Клим on 11.07.2021.
//

import UIKit
import ExpyTableView

protocol PoliciesShortViewProtocol: UIViewController{
    func updateUI()
}

class PoliciesShortViewController: UIViewController {
    var presenter: PoliciesShortPresenterProtocol!
    @IBOutlet weak var policiesShortTable: ExpyTableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var acceptButtonShell: UIButton!
    @IBOutlet weak var showFullButtonShell: UIButton!
    @IBOutlet weak var backButtonShell: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        prepareViews()
    }
    
    func prepareViews(){
        titleLabel.textColor = grayTextColor
        backButtonShell.tintColor = lightYellowColor
        
        acceptButtonShell.tintColor = grayButtonColor
        acceptButtonShell.layer.cornerRadius = 15
        acceptButtonShell.backgroundColor = .clear
        acceptButtonShell.layer.borderWidth = 2
        //acceptButtonShell.setTitleColor(grayButtonColor, for: .normal)
        acceptButtonShell.layer.borderColor = lightYellowColor.cgColor
        showFullButtonShell.tintColor = policiesButtonColor
    }
    
    func setupTable(){
        policiesShortTable.delegate = self
        policiesShortTable.dataSource = self
        policiesShortTable.rowHeight = UITableView.automaticDimension
        policiesShortTable.estimatedRowHeight = 44
                    
        //Alter the animations as you want
        policiesShortTable.expandingAnimation = .fade
        policiesShortTable.collapsingAnimation = .fade
                    
        policiesShortTable.tableFooterView = UIView()
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showFullButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "policiesFullSegue", sender: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
}



extension PoliciesShortViewController: PoliciesShortViewProtocol{
    func updateUI() {
        policiesShortTable.reloadData()
    }
}

extension PoliciesShortViewController: ExpyTableViewDataSource {
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpTitleViewCell.identifier) as! ExpTitleViewCell
        cell.titleLabel.text = presenter.getTitleText(index: section)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
}

extension PoliciesShortViewController: ExpyTableViewDelegate {
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
    
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            
        case .willCollapse:
            print("WILL COLLAPSE")
            
        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            print("DID COLLAPSE")
        }
    }
}

extension PoliciesShortViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PoliciesShortViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.countData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The cell instance that you return from expandableCellForSection: data source method is actually the first row of belonged section. Thus, when you return 4 from numberOfRowsInSection data source method, first row refers to expandable cell and the other 3 rows refer to other rows in this section.
        // So, always return the total row count you want to see in that section
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShortPolicyViewCell.identifier) as! ShortPolicyViewCell
        presenter.prepareCell(cell: cell, index: indexPath.section)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.hideSeparator()
        return cell
    }
}


