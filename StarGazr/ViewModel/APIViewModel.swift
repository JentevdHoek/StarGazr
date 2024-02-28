//
//  APIViewModel.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 27/02/2024.
//

import Foundation
import Combine

class APODViewModel: ObservableObject {
    @Published var apod: APODModel?
    
    var APIKey = "ZoGElbDxAmYlXchoGyTsjep2MiAmptdcxrNg15vk"
    
    func fetchAPOD(isRandom: Bool? = nil, date: Date? = nil) {
        
        var urlString = "https://api.nasa.gov/planetary/apod?api_key=\(APIKey)"
        
        if let isRandom = isRandom {
            urlString += "&\(isRandom ? "count=1" : "date=\(formattedDate(from: date ?? Date()))")"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let newAPOD = try decodeAPODModel(from: data)
                    
                    DispatchQueue.main.async {
                        self.apod = newAPOD
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
    
    private func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}


