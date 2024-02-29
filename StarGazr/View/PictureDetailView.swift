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
                Text(apod.title).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
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
                }
                Text(apod.explanation)
                    .padding()
            }
        }
//        .navigationTitle(apod.title)
//        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            NavigationLink(destination: PictureEditView(apod: apod), label: {Text("Edit")})
        }
    }
}
