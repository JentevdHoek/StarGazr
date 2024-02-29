//
//  FavouritesView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 28/02/2024.
//

import SwiftUI

struct FavouritesView: View {
    @Environment(FavoritesViewModel.self) var favoritesModel
    
    var body: some View {
        let favorites = favoritesModel.Favorites
        if favorites.count > 0 {
            List() {
                ForEach(favorites) { favorite in
                    FavouriteListItemView(apod: favorite)
                        .swipeActions {
                            Button(role: .destructive) {
                                favoritesModel.delete(APOD: favorite)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        } else {
            Text("No favorites 💔")
        }
    }
}
