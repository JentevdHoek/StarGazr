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
                                .frame(width: UIScreen.main.bounds.width * 3 / 5)
                        }
                    }
                } else {
                    ScrollView{
                        VStack { SearchView(apodViewModel: apodViewModel); APODView(apodViewModel: apodViewModel) }
                    }
                }
            }
            .navigationTitle("StarGazr")
            .toolbar{NavigationLink(destination: FavouritesView()) {
                Text("Favourites")
                    .font(.title2)
            }
            }
        }
        
    }
}

struct SearchView: View{
    @ObservedObject var apodViewModel: APODViewModel
    @State var date = Date()
    @State var isRandom = false
    
    func search(){
        apodViewModel.fetchAPOD(isRandom: isRandom, date: date)
    }
    
    var body: some View {
        VStack {
            Toggle(isOn: $isRandom) {
                Text("Random image")
            }.padding(.horizontal)
            HStack {
                DatePicker(
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: .date,
                    label: {
                        Text("Date")
                    }
                ).padding(.horizontal).disabled(isRandom)
            }
            Button(action: {
                search()
            }) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
            
        }
    }
}

struct APODView: View {
    @ObservedObject var apodViewModel: APODViewModel
    
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
    HomeView()
}
