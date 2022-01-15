//
//  ServerResponse.swift
//  PureMind
//
//  Created by Клим on 25.11.2021.
//

import Foundation

struct ServerResponse<Object:Decodable>: Decodable {
    var hits: [Object]
}
