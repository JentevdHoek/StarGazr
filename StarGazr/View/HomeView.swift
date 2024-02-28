//
//  ContentView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 23/02/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            APODView()
                .navigationTitle("StarGazr")
                .toolbar{NavigationLink(destination: FavouritesView().navigationTitle("Favourites")) {
                    Text("Favourites")
                        .font(.title2)
                    }
                }
        }.environment(FavoritesViewModel())
        
    }
}

struct APODView: View {
    @ObservedObject var apodViewModel = APODViewModel()
    @Environment(FavoritesViewModel.self) var favourites
    
    var body: some View {
        VStack {
            if let apod = apodViewModel.apod {
                Text(apod.title)
                    .font(.title)
                AsyncImage(url: URL(string: apod.url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Text("Failed to load image")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                Text(apod.explanation)
                    .padding()
                Button(action: { favourites.toggle(APOD: apod) }, label: {
                    if(favourites.dateIsFavorite(apod.date)){
                        Text("♥")
                            .font(.system(size: 36))
                    } else {
                        Text("♡")
                            .font(.system(size: 36))
                    }
                    
                })
            } else {
                ProgressView()
            }
        }.onAppear {
            apodViewModel.fetchAPOD()
        }
    }
}


#Preview {
    HomeView()
}
