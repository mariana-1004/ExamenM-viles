//
//  CovidInfoRequirement.swift
//  ExamenFinal
//
//  Created by Mariana Juárez Ramírez on 25/11/24.
//

import Foundation

protocol CovidRequirementProtocol {
    func getCovidData(country:String, date: String?) async -> [CovidLocation]?
}

class CovidRequirement: CovidRequirementProtocol {
    static let shared = CovidRequirement()
    let dataRepository: CovidRepository

    init(dataRepository: CovidRepository = CovidRepository.shared) {
        self.dataRepository = dataRepository
    }
    
    func getCovidData(country:String, date: String?) async -> [CovidLocation]? {
        return await dataRepository.getCovidData(country: country, date: date)
    }
}
