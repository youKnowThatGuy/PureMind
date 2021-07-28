//
//  PoliciesFullViewController.swift
//  PureMind
//
//  Created by Клим on 12.07.2021.
//

import UIKit
import ExpyTableView

protocol PoliciesFullViewProtocol: UIViewController{
    func updateUI()
}


class PoliciesFullViewController: UIViewController {
    var presenter: PoliciesFullPresenterProtocol!
    @IBOutlet weak var policiesTable: ExpyTableView!
    @IBOutlet weak var returnButtonShell: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnButtonShell.tintColor = lightYellowColor
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTable(){
        policiesTable.delegate = self
        policiesTable.dataSource = self
        policiesTable.rowHeight = UITableView.automaticDimension
        policiesTable.estimatedRowHeight = 44
                    
        //Alter the animations as you want
        policiesTable.expandingAnimation = .fade
        policiesTable.collapsingAnimation = .fade
                    
        policiesTable.tableFooterView = UIView()
        
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        let viewControllers = self.navigationController!.viewControllers
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
}

extension PoliciesFullViewController: PoliciesFullViewProtocol{
    func updateUI() {
        policiesTable.reloadData()
    }
}

extension PoliciesFullViewController: ExpyTableViewDataSource {
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpTitleRightCell.identifier) as! ExpTitleRightCell
        cell.titleLabel.text = presenter.getTitleText(index: section)
        cell.titleLabel.textColor = grayTextColor
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
}

extension PoliciesFullViewController: ExpyTableViewDelegate {
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

extension PoliciesFullViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        //print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PoliciesFullViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.countData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The cell instance that you return from expandableCellForSection: data source method is actually the first row of belonged section. Thus, when you return 4 from numberOfRowsInSection data source method, first row refers to expandable cell and the other 3 rows refer to other rows in this section.
        // So, always return the total row count you want to see in that section
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PolicyFullViewCell.identifier) as! PolicyFullViewCell
        presenter.prepareCell(cell: cell, index: indexPath.section)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.hideSeparator()
        return cell
    }
}
