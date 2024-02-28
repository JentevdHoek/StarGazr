//
//  ContentView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 23/02/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var apodViewModel = APODViewModel()

    var body: some View {
            NavigationView {
                VStack {
                    if let apod = apodViewModel.apod {
                        Text(apod.title)
                            .font(.title)
                        Text(apod.explanation)
                            .padding()
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
                    } else {
                        ProgressView()
                    }

                    // Button to navigate to ListView
                    NavigationLink(destination: FavouritesView()) {
                        Text("Go to ListView")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                .navigationTitle("StarGazr")
            }
            .onAppear {
                apodViewModel.fetchAPOD()
            }
        }
}

#Preview {
    HomeView()
}
