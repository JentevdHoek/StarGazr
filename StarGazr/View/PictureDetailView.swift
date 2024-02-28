//
//  PictureDetailView.swift
//  StarGazr
//
//  Created by Patrick Schwartzbach on 28/02/2024.
//

import SwiftUI

struct PictureDetailView: View {
    @ObservedObject var apodViewModel = APODViewModel()
    
    var body: some View {
        VStack {
            if let apod = apodViewModel.apod {
                HStack{
                    Text(apod.title)
                        .font(.title)
                    NavigationLink(destination: PictureEditView()){
                        Text("✏️")
                    }
                }
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
            } else {
                ProgressView()
            }
        }.onAppear {
            apodViewModel.fetchAPOD()
        }
    }
}

#Preview {
    PictureDetailView()
}
