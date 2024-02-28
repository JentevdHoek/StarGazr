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

    func fetchAPOD() {
            guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=\(APIKey)") else {
                return
            }

            var newAPOD: APODModel?
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    
                    do {
                        newAPOD = try JSONDecoder().decode(APODModel.self, from: data)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                }
                
                // Ensure that updates to @Published property are done on the main thread
                DispatchQueue.main.async {
                    self.apod = newAPOD
                }
            }.resume()
        }
    
    func save() {
        if let apod = apod {
            FavoritesViewModel().add(APOD: apod)
        } else {
            print("failed saving apod")
        }
    }
}

