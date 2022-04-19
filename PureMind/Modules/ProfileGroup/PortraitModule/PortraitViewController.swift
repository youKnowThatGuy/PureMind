//
//  PortraitViewController.swift
//  PureMind
//
//  Created by Клим on 02.02.2022.
//

import UIKit
import SafariServices
import ExpyTableView

protocol PortraitViewProtocol: UIViewController{
    func updateUI()
}

class PortraitViewController: UIViewController, SFSafariViewControllerDelegate{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var presenter: PortraitPresenterProtocol!
    
    @IBOutlet weak var testsTableView: ExpyTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        prepareViews()
    }
    
    func prepareViews(){
        testsTableView.separatorStyle = .none
        testsTableView.delegate = self
        testsTableView.dataSource = self
        titleLabel.textColor = grayTextColor
        descriptionLabel.textColor = textFieldColor
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func openSafari(link: String){
        let safariVC = SFSafariViewController(url: URL(string: link)!)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
}

extension PortraitViewController: PortraitViewProtocol{
    func updateUI() {
        testsTableView.reloadData()
    }
}

extension PortraitViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PortraitViewController: ExpyTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.countData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingleTestViewCell.identifier) as! SingleTestViewCell
        presenter.prepareCell(cell: cell, index: indexPath.section)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.testIndex = indexPath.section
        cell.hideSeparator()
        cell.parentVc = self
        return cell
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpPortraitViewCell.identifier) as! ExpPortraitViewCell
        cell.titleLabel.text = presenter.getTitleText(index: section)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
}

extension PortraitViewController: ExpyTableViewDelegate {
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
