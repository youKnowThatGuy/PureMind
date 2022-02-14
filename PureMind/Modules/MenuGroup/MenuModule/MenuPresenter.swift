//
//  MenuPresenter.swift
//  PureMind
//
//  Created by Клим on 05.08.2021.
//
import UIKit

protocol MenuPresenterProtocol{
    init(view: MenuViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func preparePracticCell(cell: PracticViewCell, index: Int)
    func prepareCourseCell(cell: CourseViewCell, index: Int)
    func coursesCount() -> Int
    func practicsCount() -> Int
    func loadData()
}

class MenuPresenter: MenuPresenterProtocol{
    
    weak var view: MenuViewProtocol?
    
    var currWeek = "Неделя 1"
    var coursePurchased = true
    var practics = [String]()
    var excerciseCounts = [Int]()
    var courses = [String]()
    var coursesId = [String]()
    var coursesDesc = [String]()
    
    required init(view: MenuViewProtocol) {
        self.view = view
    }
    
    func loadData(){
        NetworkService.shared.getPractices {[weak self] (result) in
            switch result{
            case let .success(tokens):
                var p = [String]()
                var ec = [Int]()
                for i in 0..<tokens.count {
                    if !p.contains(tokens[i].category){
                        p.append(tokens[i].category)
                        ec.append(1)
                    }
                    else{
                        let ind = p.lastIndex(of: tokens[i].category)
                        ec[ind!] = ec[ind!] + 1
                    }
                }
                self?.practics = p
                self?.excerciseCounts = ec
                NetworkService.shared.getCourses {[weak self] (result) in
                    switch result{
                    case let .success(tokens):
                        for token in tokens {
                            self?.courses.append(token.name)
                            self?.coursesId.append(token.id)
                            self?.coursesDesc.append(token.description)
                        }
                        self?.courses.append("Все курсы")
                        self?.practics.append("Все темы")
                        self?.view?.updateUI()
                        
                    case .failure(_):
                        fatalError("Data didnt load")
                    }
                }
                
            case .failure(_):
                fatalError("Data didnt load")
                
            }
        }
    }
    
    func conv(n: Int) -> String{
        let mas = ["а", "и", ""]
        let n = n % 100
        var str = ""
        if n >= 11 && n <= 19{
            str = mas[2]
        }
        else{
            let i = n % 10
            if i == 1{
                str = mas[0]
            }
            else if [2,3,4].contains(i){
                str = mas[1]
            }
            else{
                str = mas[2]
            }
        }
        return str
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "chatSegue":
            guard let vc = segue.destination as? ChatViewController
            else {fatalError("invalid data passed")}
            vc.presenter = ChatPresenter(view: vc)
            
        case "moodFirstSegue":
            guard let vc = segue.destination as? QuestionsNavigationController
            else {fatalError("invalid data passed")}
            vc.currMood = sender as? String
            
        case "excercisesChoiceSegue":
            guard let vc = segue.destination as? ExcerciseChoiceViewController, let index = sender as? Int
            else {fatalError("invalid data passed")}
            let string = practics[index]
            vc.presenter = ExcerciseChoicePresenter(view: vc, currPractic: string)
        
        case "courseChosenSegue":
            guard let vc = segue.destination as? CourseTabBarViewController, let index = sender as? Int
            else {fatalError("invalid data passed")}
            vc.id = coursesId[index]
            vc.name = courses[index]
            vc.courseDescription = coursesDesc[index]
            
        case "allPracticsSegue":
            guard let vc = segue.destination as? AllExcercisesViewController
            else {fatalError("invalid data passed")}
            vc.presenter = AllExcercisePresenter(view: vc)
            
        case "allCoursesSegue":
            guard let vc = segue.destination as? AllCoursesViewController
            else {fatalError("invalid data passed")}
            vc.presenter = AllCoursesPresenter(view: vc)
            
        default:
            break
        }
    }
    /*
    func changeWeek(currWeek: String) {
        self.currWeek = currWeek
        view?.updateUI(collView: "PlanView")
    }
     
    func preparePlanCell(cell: PlanViewCell, index: Int) {
        cell.dayLabel.text = "День \(index + 1)"
        cell.weekLabel.text = currWeek
        cell.titleLabel.text = "План на сегодня"
        cell.availableImageView.isHidden = coursePurchased
        cell.parentView = view
        cell.setupDesign()
    }
 */
    
    func prepareCourseCell(cell: CourseViewCell, index: Int) {
        var int = 1
        if (index + 1) % 2 == 0 && (index + 1) % 3 != 0{
            int = 2
        }
        else if (index + 1) % 3 == 0 && (index + 1) % 2 != 0 {
            int = 3
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        let image = UIImage(named: "cell_back\(int)")
        imageView.image = image
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)
        cell.courseNameLabel.text = courses[index]
        cell.layer.cornerRadius = 12
        cell.parentView = view
    }
    
    func preparePracticCell(cell: PracticViewCell, index: Int) {
        var color = UIColor(red: 254, green: 227, blue: 180)
        if (index + 1) % 3 == 0 {
            color = UIColor(red: 255, green: 228, blue: 197)
        }
        else if (index + 1) % 4 == 0 {
            color = UIColor(red: 253, green: 214, blue: 201)
        }
        else if (index + 1) % 2 == 0 && (index + 1) % 3 != 0{
            color = UIColor(red: 251, green: 210, blue: 174)
        }
        cell.practicLabel.text = practics[index]
        cell.backgroundColor = color
        if index == coursesCount() - 1{
            cell.excerciseCount.text = ""
        }
        else{
            cell.excerciseCount.text = "\(excerciseCounts[index]) техник\(conv(n: excerciseCounts[index]))"
        }
        cell.layer.cornerRadius = 14
        cell.parentView = view
    }
    
    
    func coursesCount() -> Int {
        return courses.count
    }
    
    func practicsCount() -> Int {
        return practics.count
    }
    
}
