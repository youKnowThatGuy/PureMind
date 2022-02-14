//
//  CourseTabBarViewController.swift
//  PureMind
//
//  Created by Клим on 06.02.2022.
//

import UIKit
import Parchment

class CourseTabBarViewController: UIViewController {
    
    var id: String!
    var name: String!
    var courseDescription: String!
    var lessonChosen = 0
    
    private var pagingViewController: PagingViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        let firstViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondaryTabVC") as SecondaryTabBarViewController
        firstViewController.id = id
        firstViewController.lessonChosen = lessonChosen
        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CourseInfoVC") as CourseInfoViewController
        secondViewController.titleText = name
        secondViewController.courseDescriptionText = courseDescription
             pagingViewController = PagingViewController(viewControllers: [
              firstViewController,
              secondViewController
            ])
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.menuInsets = UIEdgeInsets.init(top: 90, left: 0, bottom: -10, right: 0)
        pagingViewController.menuItemSize = .sizeToFit(minWidth: 50, height: 55)
        pagingViewController.font = UIFont(name: "Montserrat-Bold", size: 11)!
        pagingViewController.selectedFont = UIFont(name: "Montserrat-Bold", size: 11)!
        pagingViewController.textColor = UIColor(red: 237, green: 237, blue: 237)
        pagingViewController.indicatorColor = .white
        pagingViewController.menuBackgroundColor = UIColor(red: 211, green: 228, blue: 160)
        pagingViewController.selectedBackgroundColor = UIColor(red: 211, green: 228, blue: 160)
        pagingViewController.selectedTextColor = .white
        
        let backButton = UIButton(frame: CGRect(x: 20, y: 50, width: 35, height: 35))
        backButton.setTitle("", for: .normal)
        backButton.setBackgroundImage(UIImage(named: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        pagingViewController.view.addSubview(backButton)
        
        let label = UILabel()
        label.frame = CGRect.init(x: 100, y: 55, width: 320, height: 45)
        label.numberOfLines = 0
        label.text = name
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.textColor = .white
        pagingViewController.view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: backButton.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -15),
          pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        ])
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

}
