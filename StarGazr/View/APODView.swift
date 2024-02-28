//
//  APODView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 28/02/2024.
//

import SwiftUI

struct APODView: View {
    @ObservedObject var apodViewModel: APODViewModel
    @Environment(FavoritesViewModel.self) var favourites
    
    var body: some View {
        VStack {
            if let apod = apodViewModel.apod {
                Text(apod.title)
                    .font(.title)
                
                if apod.media_type == "image" {
                    AsyncImage(url: URL(string: apod.url)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Text("Failed to load image")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                } else if apod.media_type == "video" {
                    Text(apod.url)
                        .padding()
                }
                
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
        }
    }
    
}
