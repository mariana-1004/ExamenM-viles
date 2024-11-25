//
//  ContentView.swift
//  ExamenFinal
//
//  Created by Mariana Juárez Ramírez on 25/11/24.
//

import SwiftUI

struct CovidView: View {
    
    @StateObject var covidViewModel = CovidViewModel()
    @State private var country = "Mexico"
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            HStack {
                Text("Covid 19")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .allowsTightening(false)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Campo para capturar el país
            TextField("Introduce un país", text: $country)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Botón para consultar datos
            Button("Consultar Datos de COVID") {
                Task {
                    await covidViewModel.getCovidStatistics(for: country)
                }
            }
            .padding()
            
            // Lista de datos o mensaje de error
            if let errorMessage = covidViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(covidViewModel.covidData, id: \.region) { region in
                    VStack(alignment: .leading) {
                        Text("País: \(region.country)")
                        Text("Región: \(region.region)")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    CovidView()
}
