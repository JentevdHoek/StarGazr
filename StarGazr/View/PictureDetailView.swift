//
//  PictureDetailView.swift
//  StarGazr
//
//  Created by Patrick Schwartzbach on 28/02/2024.
//

import SwiftUI

struct PictureDetailView: View {
    let apod: APODModel
    
    var body: some View {
        ScrollView{
            VStack {
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
                    if let url = URL(string: apod.url) {
                        Link(destination: url) {
                            Text(apod.url)
                                .foregroundColor(.blue)
                                .underline()
                        }
                        .padding()
                    }
                }
                Text(apod.explanation)
                    .padding()
            }
        }.navigationTitle(apod.title)
        .toolbar{
            NavigationLink(destination: PictureEditView(apod: apod), label: {Text("Edit")})
        }
    }
    
}

//#Preview {
//    PictureDetailView()
//        .environment(FavoritesViewModel())
//}
