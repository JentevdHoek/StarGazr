//
//  ContentView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 23/02/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var apodViewModel = APODViewModel()

    var body: some View {
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
        }
        .onAppear {
            apodViewModel.fetchAPOD()
        }
    }
}

#Preview {
    ContentView()
}
