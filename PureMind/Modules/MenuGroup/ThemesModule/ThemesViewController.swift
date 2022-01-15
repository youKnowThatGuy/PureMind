//
//  ThemesViewController.swift
//  PureMind
//
//  Created by Клим on 30.07.2021.
//

import UIKit

protocol ThemesViewProtocol: UIViewController{
    func updateUI()
}

class ThemesViewController: UIViewController {
    var presenter: ThemesPresenterProtocol!

    @IBOutlet weak var themesCollectionView: UICollectionView!
    @IBOutlet weak var continueButtonShell: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background2")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }
    
    func prepareViews(){
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        themesCollectionView.delegate = self
        themesCollectionView.dataSource = self
        //themesCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "background2")!)
        titleLabel.textColor = grayTextColor
        descriptionLabel.textColor = grayTextColor
        continueButtonShell.setTitleColor(grayButtonColor, for: .normal)
        continueButtonShell.layer.cornerRadius = 15
        continueButtonShell.layer.borderWidth = 2
        continueButtonShell.layer.borderColor = lightYellowColor.cgColor
        
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "therapistChoiceSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    

}

extension ThemesViewController: ThemesViewProtocol{
    func updateUI() {
        themesCollectionView.reloadData()
        if presenter.selectedThemesCount() > 0{
            continueButtonShell.layer.backgroundColor = lightYellowColor.cgColor
            continueButtonShell.setTitleColor(.white, for: .normal)
            continueButtonShell.setTitle("Подтвердить", for: .normal)
        }
        else{
            continueButtonShell.setTitle("Пропустить", for: .normal)
        }
    }
}

extension ThemesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = themesCollectionView.dequeueReusableCell(withReuseIdentifier: ThemeViewCell.identifier, for: indexPath) as? ThemeViewCell
        else {fatalError("Invalid Cell kind")}
        cell.themeNotChosen = !cell.themeNotChosen
        cell.backgroundColor = toxicYellowSelected
        presenter.manageTheme(index: indexPath.row)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.themesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = themesCollectionView.dequeueReusableCell(withReuseIdentifier: ThemeViewCell.identifier, for: indexPath) as? ThemeViewCell
        else {fatalError("Invalid Cell kind")}
        
        presenter.prepareCell(cell: cell, index: indexPath.row)
        return cell
    }
    
}
