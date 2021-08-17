//
//  QuestionsNavigationController.swift
//  PureMind
//
//  Created by Клим on 17.08.2021.
//

import UIKit

class QuestionsNavigationController: UINavigationController {
    var currMood: String!
    var vcIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers.append(ModuleBuilder().createMoodModuleOne(mood: currMood, vcIndex: vcIndex))
    }

}
