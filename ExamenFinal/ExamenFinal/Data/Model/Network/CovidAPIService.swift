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
    
    func getCovidInfo(url: URL, country:String, date: String?=nil) async -> [CovidLocation]? {
        var parameters : Parameters = ["country":country]
        if let date = date {
            parameters["date"] = date
        }
            let headers: HTTPHeaders = [
                "X-Api-Key": "wLVPN1zV08lJYF7uXqgyPw==zVwp6TlVcAO1NLUf"
            ]
            
            
            let taskRequest = AF.request(url, method: .get, parameters: parameters, headers: headers).validate()
            let response = await taskRequest.serializingData().response
            
            switch response.result {
            case .success(let data):
                do {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Respuesta JSON: \(jsonString)")
                    }
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

