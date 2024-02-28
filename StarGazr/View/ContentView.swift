//
//  ContentView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 23/02/2024.
//

import SwiftUI

import Foundation

struct ContentView: View {
    @ObservedObject var viewModel = AstronomyViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.astronomyData) { astronomy in
                NavigationLink(destination: DetailView(astronomy: astronomy)) {
                    Text(astronomy.title)
                }
            }
            .navigationBarTitle("Astronomy Pictures")
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}


struct DetailView: View {
    var astronomy: AstronomyPictureOfTheDay
    
    var body: some View {
        VStack {
            Text(astronomy.title)
                .font(.title)
                .padding()
            
            Text(astronomy.explanation)
                .padding()
            
            RemoteImage(url: astronomy.url)
                .aspectRatio(contentMode: .fit)
                .padding()
        }
        .navigationBarTitle("Detail View")
    }
}

struct RemoteImage: View {
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        if let imageURL = URL(string: url), let imageData = try? Data(contentsOf: imageURL), let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
                .resizable()
        } else {
            return Image(systemName: "photo")
                .resizable()
        }
    }
}

#Preview {
    ContentView()
}
