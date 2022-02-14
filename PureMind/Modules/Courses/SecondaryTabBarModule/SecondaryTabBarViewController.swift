//
//  SecondaryTabBarViewController.swift
//  PureMind
//
//  Created by Клим on 06.02.2022.
//

import UIKit
import Parchment

class SecondaryTabBarViewController: UIViewController {
    var id: String!
    var lessonChosen = 0
    
    private var pagingViewController: PagingViewController!
    let mod = ModuleBuilder()

    override func viewDidLoad() {
        super.viewDidLoad()
        var viewControllers = [UIViewController]()
        NetworkService.shared.getAllLessonsData(courseId: id) {[weak self] (result) in
            switch result{
            case let .success(tokens):
                for i in 0..<tokens.count{
                    viewControllers.append((self?.mod.createLessonModule(data: tokens[i], index: i))!)
                }
                self?.pagingViewController = PagingViewController(viewControllers: viewControllers)
                self?.setupParchment()
                self?.setFirstVC()
                
            case let .failure(error):
                print(error)
                self?.alert()
            }
        }
    }
    
    func setFirstVC(){
        pagingViewController.select(index: lessonChosen, animated: true)
        
    }
    
    func alert(){
        let alert = UIAlertController(title: "Ошибка", message: "Проверьте ваше соединение с интернетом", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func setupParchment(){
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        //pagingViewController.menuInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: -10, right: 0)
        //pagingViewController.menuItemSize = .sizeToFit(minWidth: 50, height: 95)
        pagingViewController.font = UIFont(name: "Montserrat-Regular", size: 11)!
        pagingViewController.selectedFont = UIFont(name: "Montserrat-Semibold", size: 11)!
        pagingViewController.textColor = grayTextColor
        pagingViewController.indicatorColor = UIColor(red: 211, green: 228, blue: 160)
        pagingViewController.selectedBackgroundColor = UIColor(red: 211, green: 228, blue: 160)
        pagingViewController.selectedTextColor = .white
        NSLayoutConstraint.activate([
          pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        ])
    }

}
