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
            
            // Country field
            TextField("Introduce un país", text: $country)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Consult Buttom
            Button("Consultar Datos de COVID") {
                Task {
                    await covidViewModel.getCovidStatistics(for: country)
                }
            }
            .padding()
            
            // error msg
            if covidViewModel.covidData.isEmpty {
                if let errorMessage = covidViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            } else {
                List(covidViewModel.covidData, id: \.region) { region in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("País: \(region.country)")
                            .font(.headline)
                        Text("Región: \(region.region)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        
                        if !region.cases.isEmpty {
                            ForEach(region.cases.keys.sorted(), id: \.self) { date in
                                if let caseData = region.cases[date] {
                                    VStack(alignment: .leading) {
                                        Text("Fecha: \(date)")
                                            .font(.footnote)
                                            .foregroundColor(.blue)
                                        Text("Casos Totales: \(caseData.total)")
                                            .font(.footnote)
                                        Text("Casos Nuevos: \(caseData.new)")
                                            .font(.footnote)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        } else {
                            Text("No hay datos de casos para esta región.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .padding()
    }
}

#Preview {
    CovidView()
}
