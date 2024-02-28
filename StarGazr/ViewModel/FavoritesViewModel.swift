//
//  FavoritesViewModel.swift
//  StarGazr
//
//  Created by Patrick Schwartzbach on 28/02/2024.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var Favorites: [APODModel]?
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "favorites") {
            do {
                let decoder = JSONDecoder()
                Favorites = try decoder.decode([APODModel].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}
