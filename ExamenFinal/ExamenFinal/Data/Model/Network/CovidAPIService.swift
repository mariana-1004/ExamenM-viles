//
//  CovidAPIService.swift
//  ExamenFinal
//
//  Created by Mariana Juárez Ramírez on 25/11/24.
//

import Foundation
import Alamofire


class CovidAPIService {
    static let shared = CovidAPIService()
    let apiKey = "wLVPN1zV08IJYF7uXqgyPw==zVwp6TIVcAO1NLUf"
    
    func getCovidInfo(url: URL, country:String, date: String?=nil) async -> [CovidLocation]? {
        var parameters : Parameters = ["country":country]
        if let date = date {
            parameters["date"] = date
        }
        
        //header token
        let _: HTTPHeaders = [
                    "X-Api-Key": apiKey
                ]
        
        let taskRequest = AF.request(url, method: .get, parameters: parameters).validate()
        let response = await taskRequest.serializingData().response

        switch response.result {
        case .success(let data):
            do {
                return try JSONDecoder().decode([CovidLocation].self, from: data)
            } catch {
                debugPrint("Error al decodificar JSON: \(error.localizedDescription)")
                return nil
            }
        case let .failure(error):
            debugPrint("Error en la solicitud: \(error.localizedDescription)")
            
            return nil
        }
    }
    
}
