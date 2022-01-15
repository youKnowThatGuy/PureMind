//
//  PageExcerciseViewController.swift
//  PureMind
//
//  Created by Клим on 12.10.2021.
//

import UIKit

class PageExcerciseViewController: UIPageViewController {
    
    var info = [String]()
    var excerciseControllers = [UIViewController]()
    var mod = ModuleBuilder()
    let networkService = NetworkService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setViewControllers()
    }
    
    func start(){
        if let firstViewController = excerciseControllers.first {
                       setViewControllers([firstViewController],
                        direction: .forward,
                           animated: true,
                           completion: nil)
            
        }
    }
    
    func alert(){
        let alert = UIAlertController(title: "Ошибка", message: "Проверьте ваше соединение с интернетом", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func setViewControllers(){
        networkService.getAllExcerciseData(practicId: info[0]){ [weak self] (result) in
            switch result{
            case let .success(tokens):
                self?.excerciseControllers = (self?.mod.createAnyPractic(info: tokens, title: (self?.info[1])!, practicName: (self?.info[2])!))!
                self?.start()
                
            case .failure(_):
                self?.alert()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension PageExcerciseViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = excerciseControllers.firstIndex(of: viewController) else {
                        return nil
                    }
                    let previousIndex = viewControllerIndex - 1
                    guard previousIndex >= 0 else {
                        return nil
                    }
                    guard excerciseControllers.count > previousIndex else {
                        return nil
                    }
                    return excerciseControllers[previousIndex]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = excerciseControllers.firstIndex(of: viewController) else {
                        return nil
                    }
                    let nextIndex = viewControllerIndex + 1
                    let orderedViewControllersCount = excerciseControllers.count
                    guard orderedViewControllersCount != nextIndex else {
                        return nil
                    }
                    guard orderedViewControllersCount > nextIndex else {
                        return nil
                    }
                    return excerciseControllers[nextIndex]
            }
}
