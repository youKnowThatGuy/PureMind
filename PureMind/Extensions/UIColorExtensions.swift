//
//  UIColorExtensions.swift
//  PureMind
//
//  Created by Клим on 28.07.2021.
//

import UIKit

let blueBackgorundColor = UIColor(red: 226, green: 233, blue: 252)
let grayTextColor = UIColor(red: 103, green: 103, blue: 130) //676767
let grayButtonColor = UIColor(red: 196, green: 196, blue: 196) //C4C4C4
let darkGrayTextColor = UIColor(red: 175, green: 175, blue: 175) //AFAFAF
let textFieldColor = UIColor(red: 98, green: 98, blue: 98) //626262
let policiesButtonColor = UIColor(red: 78, green: 107, blue: 243)
let lightYellowColor = UIColor(red: 249, green: 207, blue: 136) //F9CF88

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
}
