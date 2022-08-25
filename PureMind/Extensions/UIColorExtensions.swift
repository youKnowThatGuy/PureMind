//
//  UIColorExtensions.swift
//  PureMind
//
//  Created by Клим on 28.07.2021.
//

import UIKit

let blueBackgorundColor = UIColor(red: 226, green: 233, blue: 252)
let lightBlueColor = UIColor(red: 176, green: 188, blue: 246)
let grayTextColor = UIColor(red: 103, green: 103, blue: 130) //676767
let grayButtonColor = UIColor(red: 196, green: 196, blue: 196) //C4C4C4
let darkGrayTextColor = UIColor(red: 175, green: 175, blue: 175)
let titleBlueColor = UIColor(red: 198, green: 222, blue: 255)
let textFieldColor = UIColor(red: 98, green: 98, blue: 98) //626262
let policiesButtonColor = UIColor(red: 78, green: 107, blue: 243)
let lightYellowColor = UIColor(red: 249, green: 207, blue: 136) //F9CF88

let toxicYellow = UIColor(red: 251, green: 255, blue: 203) //FBFFCB
let toxicYellowSelected = UIColor(red: 249, green: 255, blue: 184) //F9FFB8
let titleYellow = UIColor(red: 255, green: 141, blue: 54)

let perfectMood = UIColor(red: 144, green: 191, blue: 255)
let goodMood = UIColor(red: 199, green: 225, blue: 179)
let normalMood = UIColor(red: 254, green: 235, blue: 138)
let badMood = UIColor(red: 252, green: 177, blue: 120)
let awfulMood = UIColor(red: 249, green: 117, blue: 96)

let newButtonLabelColor = UIColor(red: 76, green: 89, blue: 135)
let lightTextColor = UIColor(red: 164, green: 175, blue: 225)


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
    func add(overlay: UIColor) -> UIColor {
           var bgR: CGFloat = 0
           var bgG: CGFloat = 0
           var bgB: CGFloat = 0
           var bgA: CGFloat = 0
           
           var fgR: CGFloat = 0
           var fgG: CGFloat = 0
           var fgB: CGFloat = 0
           var fgA: CGFloat = 0
           
           self.getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
           overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)
           
           let r = fgA * fgR + (1 - fgA) * bgR
           let g = fgA * fgG + (1 - fgA) * bgG
           let b = fgA * fgB + (1 - fgA) * bgB
           
           return UIColor(red: r, green: g, blue: b, alpha: 1.0)
       }
}
