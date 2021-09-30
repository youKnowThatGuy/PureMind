//
//  TherapistPriceViewController.swift
//  PureMind
//
//  Created by Клим on 12.09.2021.
//

import UIKit

protocol TherapistPriceViewProtocol: UIViewController{
    func updateUI()
}

class TherapistPriceViewController: UIViewController {
    
    var presenter: TherapistPricePresenterProtocol!
    
    @IBOutlet weak var backButtonShell: UIButton!
    @IBOutlet weak var controllerTitleLabel: UILabel!
    @IBOutlet weak var tariffsCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLayout()
        tariffsCollectionView.delegate = self
        tariffsCollectionView.dataSource = self
    }
    
    func prepareLayout(){
        backButtonShell.tintColor = lightYellowColor
        controllerTitleLabel.textColor = grayTextColor
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension TherapistPriceViewController: TherapistPriceViewProtocol{
    func updateUI() {
        print("Ok!")
    }
}

extension TherapistPriceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TariffViewCell.identifier, for: indexPath) as? TariffViewCell
        else {fatalError("Invalid Cell kind")}
        presenter.prepareCell(cell: cell, index: indexPath.row)
        return cell

    }
    
}
