//
//  PracticesInfo.swift
//  PureMind
//
//  Created by Клим on 25.11.2021.
//

import Foundation

struct PracticesInfo: Decodable{
    var id: String
    var name: String
    var category: String
}

struct ShortExcerciseInfo: Decodable{
    var id: String
    var number: String
}

struct ExcerciseInfo: Decodable{
    var id: String
    var number: String
    var description: String
    var type: String
    var audio: String?
    var image: String?
    var answers: [ExcerciseAnswer]?
}

struct ExcerciseAnswer: Decodable{
    var id: String
    var text: String
}
