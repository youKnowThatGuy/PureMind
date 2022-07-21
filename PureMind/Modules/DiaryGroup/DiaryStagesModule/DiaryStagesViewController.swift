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
    var presenter: DiaryStagesPresenterProtocol!
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background10")
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
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        stagesTableView.delegate = self
        stagesTableView.dataSource = self
        stagesTableView.backgroundColor = UIColor.clear
        titleLabel.textColor = .white
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
        cell.backgroundColor = UIColor(red: 254, green: 250, blue: 234)
        cell.titleLabel.textColor = UIColor(red: 254, green: 146, blue: 62)
        cell.titleLabel.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 251, green: 210, blue: 174), thickness: 1)
        cell.leftColorView.backgroundColor =  lightYellowColor
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
}
