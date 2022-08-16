//
//  EverydayNoteViewController.swift
//  PureMind
//
//  Created by Клим on 20.07.2022.
//

import UIKit

class EverydayNoteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var readyButtonShell: UIButton!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteBackgroundView: UIView!
    var typeFlag = false
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background3")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    var questions = ["Какой бы я хотел(а) видеть свою жизнь?", "Что мне мешает начать меняться?", "Что бы хотелось изменить?", "Достаточно ли времени я уделяю своему ментальному здоровью?", "Общение с кем приносит мне удовольствие?", "Кто меня вдохновляет на свершения?", "Что может меня наполнить ? Чем я люблю заниматься?", "Доволен ли я своей жизнью?", "Достижимы ли мои цели и задачи? Не слишком ли много я от себя требую?", "Какие достижения у меня есть на данный момент?", "Какие действия я должен(-на) предпринять, чтобы прийти к своей цели? ", "Мне важно мое мнение или мнение окружающих касательно моей жизни?", "Чего я боюсь? Какие эмоции у меня вызывают возможные перемены?", "Чем бы мне на самом деле хотелось заниматься?", "Почему я сделал выбор в пользу текущей деятельности?", "Что приносит мне ощущения радости и счастья?", "Что дарит моей жизни значимость?", "Какие мои сильные и слабые стороны?", "Чему бы я хотел(а) себя посвятить?", "Как я забочусь о себе, когда нахожусь в эмоционально подавленном состоянии?", "Кто или что помогает мне выходить из подавленного состояния?", "Чувствую ли я себя комфортно и спокойно в отношениях с моим партнером/другом/родителем?", "Комфортно ли мне проводить время в одиночестве?", "Какие поступки людей раздражают меня больше всего и почему? Может быть я делаю тоже самое?", "Какой способ самовыражения для меня самый подходящий?", "У вас есть хобби, в которое вы погружаетесь с головой?", "Как я поощряю себя за выполнение заранее намеченных целей?", "Много ли людей меня окружает, которые поддерживают меня в трудные моменты?", "Чему я бы хотела уделить больше внимания в будущем, какие навыки улучшить?", "На что бы Я хотел(а) тратить больше времени в своей жизни?", "Часто ли я хвалю себя за что-то?", "Что я думаю о себе, когда терплю неудачу?", "Что я думаю о себе, когда одерживаю победу?" ]
    
    var affirms = ["Я разрешаю себе быть собой.", "Я принимаю свои эмоции и позволяю им выполнять свою функцию.", "Я забочусь о себе и уделяю себе внимание, потому что заслуживаю этого.", "Я верю в то, что я на правильном пути.", "Мой мозг полон отличных идей.", "Я направляю свои силы на то, что для меня важно.", "Я каждый день стараюсь научиться чему‑то новому.", "Сегодня я на шаг приближусь к своей цели.", "Мои мысли не управляют мной, я управляю своими мыслями.", "Я благодарен (-на) за то, что живу.", "Моё отношение к себе зависит только от меня и ни от кого другого.", "Я верю в свой потенциал.", "Я отличаюсь от других, поэтому и успешным (-ой) я буду по‑своему.", "Сегодня мой разум и сердце открыты ко всему новому.", "Я не боюсь постоять за себя.", "Я знаю, что могу добиться всего, чего захочу.", "Я неидеальный (-ая), и я не корю себя за это.", "Я способен (-на) любить и заслуживаю любви.", "Я принимаю форму своего тела и считаю его красивым.", "Я могу. Я сделаю. И точка.", "Мои чувства в моей власти, и сегодня я выбираю быть счастливым (-ой).", "Я не сравниваю себя с незнакомцами из интернета.", "Я прощаю тех, кто причинил мне боль, и отпускаю обиды.", "Сейчас мне тяжело, но это не будет длиться вечно.", "Я не боюсь ошибаться.", "У меня достаточно сил, чтобы переписать свою историю.", "Я ценю себя.", "Любовь к себе — это моё естественное состояние", "Моё тело заслуживает моего уважения и заботы.", "Это моё тело, и я его люблю.", "Я знаю, что заслуживаю похвалы, и принимаю её.", "Я не даю моим страхам управлять мной.", "Я не извиняюсь за то, какой (-ая) я есть.", "Я не боюсь просить о помощи."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }
    
    func prepareViews(){
        titleLabel.text = "Аффирмации"
        noteLabel.text = affirms[Int.random(in:  0..<33)]
        if typeFlag == true{
            titleLabel.text = "Вопросы на каждый день"
            noteLabel.text = questions[Int.random(in:  0..<35)]
        }
        titleLabel.textColor = .white
        readyButtonShell.setTitleColor(.white, for: .normal)
        readyButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        readyButtonShell.layer.cornerRadius = 15
        noteBackgroundView.backgroundColor = UIColor(red: 253, green: 247, blue: 221)
        noteLabel.textColor = grayTextColor
        imageView.isUserInteractionEnabled = true
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func readyButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
