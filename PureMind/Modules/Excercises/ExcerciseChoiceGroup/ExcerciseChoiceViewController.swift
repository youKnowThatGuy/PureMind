//
//  ExcerciseChoiceViewController.swift
//  PureMind
//
//  Created by Клим on 07.10.2021.
//

import UIKit
protocol ExcerciseChoiceViewProtocol: UIViewController{
    func updateUI(practic: String)
    func excerciseChosen(index: Int)
    func failedToLoad()
}

class ExcerciseChoiceViewController: UIViewController {
    
    @IBOutlet weak var backButtonShell: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var practicsTableView: UITableView!
    
    var presenter: ExcerciseChoicePresenterProtocol!
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background5")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        prepareCollectionView()
        prepareViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.isHidden = true
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageView.isHidden = false
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func prepareViews(){
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
    }
    
    func prepareCollectionView(){
        practicsTableView.delegate = self
        practicsTableView.dataSource = self
        practicsTableView.tableFooterView = UIView()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
    func alert(){
        let alert = UIAlertController(title: "Ошибка", message: "Проверьте ваше соединение с интернетом", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    


}

extension ExcerciseChoiceViewController: ExcerciseChoiceViewProtocol{
    func failedToLoad() {
        alert()
        navigationController?.popViewController(animated: true)
    }
    
    func updateUI(practic: String) {
        practicsTableView.reloadData()
        titleLabel.text = practic
    }
    
    func excerciseChosen(index: Int) {
        performSegue(withIdentifier: "pageExcerciseSegue", sender: presenter.getExcerciseCode(index: index))
    }
}

extension ExcerciseChoiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.practicsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingleExcerciseViewCell.identifier) as! SingleExcerciseViewCell
        presenter.prepareCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        excerciseChosen(index: indexPath.row)
    }
}
