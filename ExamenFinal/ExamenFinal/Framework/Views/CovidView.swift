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
            
            // Selector de país
            TextField("Introduce un país", text: $country)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Selector de fecha
            DatePicker("Selecciona una fecha", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            Button("Consultar Datos de COVID") {
                Task {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let formattedDate = dateFormatter.string(from: selectedDate)
                    
                    await covidViewModel.getCovidStatistics(for: country, date: formattedDate)
                }
                
            }.padding()
            
            // Mensajes de error
            if let error = covidViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            // Lista de datos
            List(covidViewModel.covidData, id: \.region) { region in
                VStack(alignment: .leading) {
                    Text("País: \(region.country)")
                    Text("Región: \(region.region)")
                }
            }
            
            
            .padding()
        }
    }
}

#Preview {
    CovidView()
}
