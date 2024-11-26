//
//  CovidViewModel.swift
//  ExamenFinal
//
//  Created by Mariana Juárez Ramírez on 25/11/24.
//

import Foundation

class CovidViewModel: ObservableObject {
    @Published var covidData: [CovidLocation] = []
    @Published var errorMessage: String?
    
    var covidRequirement: CovidRequirementProtocol
    
    
    init(covidRequirement: CovidRequirementProtocol = CovidRequirement.shared) {
        self.covidRequirement = covidRequirement
    }
    
    @MainActor
    func getCovidStatistics(for country: String, date: String? = nil) async {
        let covidRepository = CovidRepository()
        
        do {
            if let data = await covidRequirement.getCovidData(country: country, date: date) {
                self.covidData = data
            } else {
                self.errorMessage = "No se encontraron datos para el país \(country)."
            }
        }
    }
}
