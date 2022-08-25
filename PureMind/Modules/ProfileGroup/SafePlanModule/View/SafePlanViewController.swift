//
//  SafePlanViewController.swift
//  PureMind
//
//  Created by Клим on 25.02.2022.
//

import UIKit
import ExpyTableView

protocol SafePlanViewProtocol: UIViewController{
    func updateUI()
}

class SafePlanViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plansTableView: ExpyTableView!
    @IBOutlet weak var topView: UIView!
    var presenter: SafePlanPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        presenter.loadData()
        topView.backgroundColor = .white
        topView.layer.cornerRadius = 20
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background12")!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.cacheData()
    }
    
    
    func prepareViews(){
        //let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        //view.addGestureRecognizer(tap)
        titleLabel.textColor = newButtonLabelColor
        plansTableView.delegate = self
        plansTableView.dataSource = self
        plansTableView.separatorStyle = .none
        plansTableView.backgroundColor = .clear
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SafePlanViewController: SafePlanViewProtocol{
    func updateUI() {
        plansTableView.reloadData()
    }
}

extension SafePlanViewController: ExpyTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.plansCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpTitlePlanCell.identifier) as! ExpTitlePlanCell
        presenter.prepareTitleCell(cell: cell, index: section)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SafePlanTableViewCell.identifier) as! SafePlanTableViewCell
        presenter.preparePlanCell(cell: cell, index: indexPath.section)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.hideSeparator()
        return cell
    }
}

extension SafePlanViewController: ExpyTableViewDelegate {
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

extension SafePlanViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
