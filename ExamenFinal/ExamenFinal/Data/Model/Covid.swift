//
//  Covid.swift
//  ExamenFinal
//
//  Created by Mariana Juárez Ramírez on 25/11/24.
//

import Foundation

struct CovidCases: Codable {
    var total: Int
    var new: Int
}

struct CovidLocation: Codable{
    var country: String
    var region: String
    var cases:[String: CovidCases]
    
}
