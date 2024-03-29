//
//  FavouriteListItemView.swift
//  StarGazr
//
//  Created by Patrick Schwartzbach on 28/02/2024.
//

import SwiftUI

struct FavouriteListItemView: View {
    var apod: APODModel
    
    var body: some View {
        NavigationLink(destination: PictureDetailView(apod: apod))
        {
            HStack{
                if apod.media_type == "image" {
                    AsyncImage(url: URL(string: apod.url)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 50, height: 50)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 50, height: 50)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "play.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Text(apod.title)
            }
        }
            
    }
}
