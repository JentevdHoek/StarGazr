//
//  APIViewModel.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 27/02/2024.
//

import Foundation
import Combine

class AstronomyViewModel: ObservableObject {
    @Published var astronomyData: [AstronomyPictureOfTheDay] = []
    var APiKey = "ZoGElbDxAmYlXchoGyTsjep2MiAmptdcxrNg15vk"
    
    func fetchData() {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=ZoGElbDxAmYlXchoGyTsjep2MiAmptdcxrNg15vk") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error fetching data: \(error)")
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([String: [AstronomyPictureOfTheDay]].self, from: data)
                
                if let astronomyArray = decodedData["data"] {
                    DispatchQueue.main.async {
                        self.astronomyData = astronomyArray
                    }
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
