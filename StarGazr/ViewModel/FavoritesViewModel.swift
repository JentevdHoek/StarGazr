//
//  FavoritesViewModel.swift
//  StarGazr
//
//  Created by Patrick Schwartzbach on 28/02/2024.
//

import Foundation

@Observable
class FavoritesViewModel {
    var Favorites: [APODModel] = []
    
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
    
    func dateIsFavorite(_ date: String) -> Bool {
        return Favorites.contains(where: {$0.date == date})
    }
    
    func add(APOD: APODModel) {
        if dateIsFavorite(APOD.date) {
            return
        }
                
        Favorites.append(APOD)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(Favorites)
            UserDefaults.standard.set(data, forKey: "favorites")
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }
    
    func delete(APOD: APODModel) {
        if let index = Favorites.firstIndex(where: {$0.date == APOD.date}) {
            Favorites.remove(at: index)
            save()
        }
    }
    
    func toggle(APOD: APODModel) {
        if dateIsFavorite(APOD.date) {
            delete(APOD: APOD)
        } else {
            add(APOD: APOD)
        }
    }
}
