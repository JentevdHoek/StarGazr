//
//  FavouritesView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 28/02/2024.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var favoritesModel = FavoritesViewModel()
    
    var body: some View {
        if let favorites = favoritesModel.Favorites {
            List(favorites.compactMap{ $0 }) { favorite in
                FavouriteListItemView()
            }
        } else {
            Text("No favorites")
        }
    }
}

#Preview {
    FavouritesView()
}
