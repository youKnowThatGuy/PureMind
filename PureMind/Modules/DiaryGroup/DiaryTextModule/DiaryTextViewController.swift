//
//  DiaryTextViewController.swift
//  PureMind
//
//  Created by Клим on 21.07.2022.
//

import UIKit

class DiaryTextViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var saveButtonShell: UIButton!
    
    var titleText: String!
    var mainText: String!
    var buttonText = "Далее"
    var hideTimePicker = true
    @IBOutlet weak var timePicker: UITextView!
    
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
        titleLabel.textColor = .white
        textLabel.textColor = .white
        titleLabel.text = titleText
        textLabel.text = mainText
        saveButtonShell.setTitleColor(.white, for: .normal)
        saveButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        saveButtonShell.layer.cornerRadius = 15
        saveButtonShell.setTitle(buttonText, for: .normal)
        tuneTimePicker()
    }
    
    func tuneTimePicker(){
        timePicker.isHidden = hideTimePicker
        timePicker.backgroundColor = UIColor(red: 254, green: 250, blue: 234)
        timePicker.layer.borderWidth = 1
        timePicker.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        timePicker.layer.cornerRadius = 15
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh::MM"
        timePicker.text = formatter.string(from: time)
        timePicker.textColor = .black
        let timePick = UIDatePicker()
        timePick.datePickerMode = .time
        timePick.frame.size = CGSize(width: 0, height: 250)
        timePick.addTarget(self, action: #selector(timePickerValueChanged(sender:)) , for: UIControl.Event.valueChanged)
        timePicker.inputView = timePick
    }
    
    @objc func timePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:MM"
        timePicker.text = formatter.string(from: sender.date)
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        var flag = true
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryTextVC") as? DiaryTextViewController)!
        vc.titleText = titleText
        switch titleText {
        case "Перед сном 1.0":
            switch mainText{
            case "Доброго вечера, дорогой друг!":
                vc.mainText = "Прежде чем мы начнем, прими удобное положение, расслабь тело и сделай несколько глубоких вдохов."
            case "Прежде чем мы начнем, прими удобное положение, расслабь тело и сделай несколько глубоких вдохов.":
                vc.mainText = "Отлично! Теперь начнем"
            case "Отлично! Теперь начнем":
                vc.mainText = "Сейчас я попрошу тебя поразмышлять о своем дне и о трех вещах, за которые ты можешь себя поблагодарить. В некоторые дни эти вещи могут казаться важными, в другие же - обыденными - это нормально."
            case "Сейчас я попрошу тебя поразмышлять о своем дне и о трех вещах, за которые ты можешь себя поблагодарить. В некоторые дни эти вещи могут казаться важными, в другие же - обыденными - это нормально.":
                vc.mainText = "Это важно, потому что именно в процессе признания положительных моментов, какими бы езначительными они ни казались,  мы развиваем чувство благодарности за то, что живем."
            case "Это важно, потому что именно в процессе признания положительных моментов, какими бы езначительными они ни казались,  мы развиваем чувство благодарности за то, что живем.":
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryNoteVC") as? DiaryNoteViewController)!
                vc.titleText = titleText
                vc.buttonText = "Далее"
                vc.descText = "Итак. Первая вещь, за которую ты чувствуешь благодарность сегодня:"
                flag = false
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "Ты молодец! При ежедневной практике эта простая привычка благодарности может оказать мощное влияние на общее восприятие жизни, так что до встречи завтра!":
                flag = false
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 10], animated: true)
                
            default:
                break
            }
            
        case "Перед сном 2.0":
            switch mainText{
            case "Лучшая забота о себе - находить время для расслабляющих занятий за час перед сном. Это помогает мозгу чувствовать себя в безопасности перед отходом в мир грез.":
                vc.mainText = "Когда мы испытываем стресс, у нас часто возникают проблемы со сном.Это происходит потому,  что наш мозг воспринимает стрессовые события как признак наличия угрозы…и поэтому последнее, что он хочет сделать это заснуть! Он хочет оставаться начеку, чтобы предотвратить опасность.Чтобы убедить наш разум в том, что сейчас можно полностью расслабиться, мы можем заранее провести несколько успокаивающих практик."
                
            case "Когда мы испытываем стресс, у нас часто возникают проблемы со сном.Это происходит потому,  что наш мозг воспринимает стрессовые события как признак наличия угрозы…и поэтому последнее, что он хочет сделать это заснуть! Он хочет оставаться начеку, чтобы предотвратить опасность.Чтобы убедить наш разум в том, что сейчас можно полностью расслабиться, мы можем заранее провести несколько успокаивающих практик.":
                vc.mainText = "Выбери медленное, не требующее сильной интеллектуальной нагрузки занятие, чтобы твое тело могло перейти в состояние умиротворения."
                
            case "Выбери медленное, не требующее сильной интеллектуальной нагрузки занятие, чтобы твое тело могло перейти в состояние умиротворения.":
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryThemeVC") as? DiaryThemeViewController)!
                vc.firstText = "Какое успокаивающее занятие перед сном ты сделаешь сегодня? (Например: почитать книгу, посмотреть серию спокойного сериала, сходить в душ, порисовать и тд.)"
                vc.titleText = titleText
                vc.hideViews = true
                flag = false
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "Последний вопрос, который поможет приятно завершить этот день.":
                vc.mainText = "Есть ли что-то, что ты бы хотел оставить в этом дне и не брать с собой в будущее? Это может быть все, что угодно, с чем бы ты хотел больше не встречаться в своей жизни."
                
            case "Есть ли что-то, что ты бы хотел оставить в этом дне и не брать с собой в будущее? Это может быть все, что угодно, с чем бы ты хотел больше не встречаться в своей жизни.":
                vc.mainText = "Сделай глубокий вдох-выдох и отпусти это."
                
            case "Сделай глубокий вдох-выдох и отпусти это.":
                vc.mainText = "Отличная работа! А теперь время расслабиться и подготовиться ко сну."
                vc.buttonText = "Готово"
            
            case "Отличная работа! А теперь время расслабиться и подготовиться ко сну.":
                flag = false
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 9], animated: true)
                
            default:
                break
            }
            
        case "Утренний дневник":
            switch mainText{
            case "Доброе утро, дорогой друг!":
                vc.mainText = "Перед началом прими удобное положение и расслабь тело"
                
            case "Перед началом прими удобное положение и расслабь тело":
                vc.mainText = "Отлично! Сделай глубокий вдох и сфокусируйся на предстоящем дне."
            
            case "Отлично! Сделай глубокий вдох и сфокусируйся на предстоящем дне.":
                vc.mainText = "О чем ты сейчас думаешь? Осознай свои мысли, но не анализируй слишком сильно."
                
            case "О чем ты сейчас думаешь? Осознай свои мысли, но не анализируй слишком сильно.":
                vc.mainText = "Что ты с нетерпением ждешь сегодня?Это может быть что-то очень простое, но приятное, как чашка кофе, а также большое жизненное событие!"
                
            case "Что ты с нетерпением ждешь сегодня?Это может быть что-то очень простое, но приятное, как чашка кофе, а также большое жизненное событие!":
                vc.mainText = "Отлично! Надеюсь, эта мысль немного порадовала тебя, но, чтобы не забывать о важном, возвращайся к этой записи в любое время на протяжении дня."
                vc.buttonText = "Готово"
            
            case "Отлично! Надеюсь, эта мысль немного порадовала тебя, но, чтобы не забывать о важном, возвращайся к этой записи в любое время на протяжении дня.":
                flag = false
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 7], animated: true)
                
            default:
                break
            }
            
        case "Вечернее планирование":
            switch mainText{
            case "Чувство ясности и уверенности в завтрашнем дне поможет тебе быстрее расслабиться  и отдохнуть.":
                vc.mainText = "Приняв привычку формулировать задачи на предстоящий день, ты даешь себе разрешение расслабиться полностью ночью, потому что знаешь, что уже позаботился о следующем дне, и он стал более определенным для тебя."
                
            case "Приняв привычку формулировать задачи на предстоящий день, ты даешь себе разрешение расслабиться полностью ночью, потому что знаешь, что уже позаботился о следующем дне, и он стал более определенным для тебя.":
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryNoteVC") as? DiaryNoteViewController)!
                vc.titleText = titleText
                vc.buttonText = "Далее"
                vc.descText = "Итак, сформулируй свою установку на завтра, записав как минимум одну вещь, которую хочешь сделать."
                flag = false
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "Прекрасно! А теперь запиши конкрет-ное время, когда ты это сделаешь. Здесь тебе нужно быть максимально точным в отношении сроков.":
                vc.mainText = "Отлично! Ты определился с завтрашним первостепенным делом - так что можешь позволить себе перестать думать об этом сейчас, отдохнуть и полностью расслабиться, ведь это все только завтра!"
                vc.buttonText = "Готово"
                
            case "Отлично! Ты определился с завтрашним первостепенным делом - так что можешь позволить себе перестать думать об этом сейчас, отдохнуть и полностью расслабиться, ведь это все только завтра!":
                vc.mainText = "Что ты с нетерпением ждешь сегодня?Это может быть что-то очень простое, но приятное, как чашка кофе, а также большое жизненное событие!"
                flag = false
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 7], animated: true)
                
            default:
                break
            }

            
            
        default:
            break
        }
        if flag == true {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
