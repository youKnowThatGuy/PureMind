//
//  DiaryStagesViewController.swift
//  PureMind
//
//  Created by Клим on 20.07.2022.
//

import UIKit

protocol DiaryStagesViewProtocol: UIViewController{
    func updateUI()
}

class DiaryStagesViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stagesTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    var presenter: DiaryStagesPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }
    
    func prepareViews(){
        self.navigationController?.isNavigationBarHidden = true
        topView.backgroundColor = .clear
        topView.layer.borderColor = newButtonLabelColor.cgColor
        topView.layer.borderWidth = 2
        topView.layer.cornerRadius = 20
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        stagesTableView.delegate = self
        stagesTableView.dataSource = self
        stagesTableView.backgroundColor = .clear
        titleLabel.textColor = newButtonLabelColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
}

extension DiaryStagesViewController: DiaryStagesViewProtocol{
    func updateUI() {
        stagesTableView.reloadData()
    }
}

extension DiaryStagesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.stagesCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            performSegue(withIdentifier: "everydayNoteSegue", sender: true)
        case 1:
            performSegue(withIdentifier: "everydayNoteSegue", sender: false)
        case 2:
            performSegue(withIdentifier: "showDiaryNotesSegue", sender: nil)
        case 3:
            performSegue(withIdentifier: "showDiaryTextSegue", sender: ["Перед сном 1.0", "Доброго вечера, дорогой друг!"])
        case 4:
            performSegue(withIdentifier: "showDiaryTextSegue", sender: ["Вечернее планирование", "Чувство ясности и уверенности в завтрашнем дне поможет тебе быстрее расслабиться  и отдохнуть."])
        case 5:
            performSegue(withIdentifier: "showDiaryTextSegue", sender: ["Перед сном 2.0", "Лучшая забота о себе - находить время для расслабляющих занятий за час перед сном. Это помогает мозгу чувствовать себя в безопасности перед отходом в мир грез."])
        case 6:
            performSegue(withIdentifier: "showDiaryTextSegue", sender: ["Утренний дневник", "Доброе утро, дорогой друг!"])
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpPracticViewCell.identifier) as! ExpPracticViewCell
        cell.titleLabel.text = presenter.getTitleText(index: indexPath.row)
        cell.stageCell = true
        var backgroundName = ""
        
        switch indexPath.row{
        case 0:
            backgroundName = "diary4"
        case 1:
            backgroundName = "diary4"
        case 2:
            backgroundName = "diary3"
        case 3:
            backgroundName = "diary1"
        case 4:
            backgroundName = "diary1"
        case 5:
            backgroundName = "diary1"
        case 6:
            backgroundName = "diary2"
        default:
            break
        }
        
        let imageView: UIImageView = {
                let imageView = UIImageView(frame: .zero)
                imageView.image = UIImage(named: backgroundName)
                imageView.contentMode = .scaleAspectFill
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
        
        cell.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: -10),
                    imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: -30),
                    imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 30),
                    imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 20)
                ])
        //cell.backgroundColor = UIColor(patternImage: UIImage(named: backgroundName)!)
        cell.titleLabel.textColor = newButtonLabelColor
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
}
