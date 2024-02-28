//
//  ContentView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 23/02/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var apodViewModel = APODViewModel()
    @Environment(\.verticalSizeClass) var sizeClass
    
    var body: some View {
        NavigationView {
            VStack{
                if sizeClass == .compact {
                    HStack(spacing: 0) {
                        VStack{
                            SearchView(apodViewModel: apodViewModel)
                            Spacer()
                        }.padding(.vertical)
                        ScrollView {
                            APODView(apodViewModel: apodViewModel)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(width: UIScreen.main.bounds.width * 2 / 3)
                        }
                    }
                } else {
                    ScrollView{
                        VStack { SearchView(apodViewModel: apodViewModel); APODView(apodViewModel: apodViewModel) }
                    }
                }
            }
            .navigationTitle("StarGazr")
            .toolbar{NavigationLink(destination: FavouritesView().navigationTitle("Favourites")) {
                Text("Favourites")
                    .font(.title2)
            }
            }
        }.environment(FavoritesViewModel())
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    HomeView()
}
