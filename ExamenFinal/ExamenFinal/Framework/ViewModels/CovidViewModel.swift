//
//  CovidViewModel.swift
//  ExamenFinal
//
//  Created by Mariana Juárez Ramírez on 25/11/24.
//

import Foundation

class CovidViewModel: ObservableObject {
    @Published var covidData: [CovidLocation] = []
    @Published var errorMessage: String? //Considering if i take this off
    
    
    var covidRequirement: CovidRequirementProtocol
    
    
    init(covidRequirement: CovidRequirementProtocol = CovidRequirement.shared) {
        self.covidRequirement = covidRequirement
    }
    
    @MainActor
    func getCovidStatistics(for country: String, date: String? = nil) async {
        let covidRepository = CovidRepository()
        
        do {
            // Llamada al requerimiento para obtener los datos
            if let data = await covidRequirement.getCovidData(country: country, date: date) {
                self.covidData = data
            } else {
                // En caso de error, mostramos un mensaje
                self.errorMessage = "No se encontraron datos para el país \(country)."
            }
        }
    }
}
