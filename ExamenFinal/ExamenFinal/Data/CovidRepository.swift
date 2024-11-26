//
//  PokemonRepository.swift
//  ExamenFinal
//
//  Created by Mariana Juárez Ramírez on 25/11/24.
//

import Foundation

struct Api {
    static let base = "https://api.api-ninjas.com/v1"
    
    
    struct routes {
        static let route = "/covid19"
    }
}

protocol CovidAPIProtocol {
    
    func getCovidData(country:String, date: String?) async -> [CovidLocation]?
}

class CovidRepository: CovidAPIProtocol {
    static let shared = CovidRepository()
    let nservice: CovidAPIService
    
    init(nservice: CovidAPIService = CovidAPIService.shared) {
        self.nservice = nservice
    }
    
    func getCovidData(country:String, date: String?) async -> [CovidLocation]? {
        return await nservice.getCovidInfo(url: URL(string:"\(Api.base)\(Api.routes.route)")!, country: country, date: date)
    }

}

