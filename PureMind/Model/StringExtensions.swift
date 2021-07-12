//
//  StringExtensions.swift
//  PureMind
//
//  Created by Клим on 11.07.2021.
//

import Foundation

extension String {
    var latinCharactersOnly: Bool {
        return self.range(of: "\\P{Latin}", options: .regularExpression) == nil
    }
    
    var russianOnly: String{
        let okayChars = Set("йцукенгшщзхъфывапролджэёячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮ")
        return self.filter {okayChars.contains($0) }
    }
}
