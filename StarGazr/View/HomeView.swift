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
            .toolbar{NavigationLink(destination: FavouritesView().navigationTitle("Favourites")) {
                Text("Favourites")
                    .font(.title2)
            }
            }
        }.environment(FavoritesViewModel())
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchView: View{
    @ObservedObject var apodViewModel: APODViewModel
    @State var selectedDate = Date()
    @State var isRandom = false
    @State private var shouldPerformInitialSearch = true
    
    let selectedDateKey = "stargazr.key.date"
    let isRandomKey = "stargazr.key.random"
    
    func search(){
        apodViewModel.fetchAPOD(isRandom: isRandom, date: selectedDate)
    }
    
    func initView() {
        let standard = UserDefaults.standard
        
        if standard.object(forKey: selectedDateKey) == nil {
            // Convert the Date to a double value and save it
            let selectedDateValue = selectedDate.timeIntervalSinceReferenceDate
            standard.set(selectedDateValue, forKey: selectedDateKey)
            standard.synchronize()
        }
        
        selectedDate = Date(timeIntervalSinceReferenceDate: standard.double(forKey: selectedDateKey))
        
        
        if standard.object(forKey: isRandomKey) == nil {
            standard.set(isRandom, forKey: isRandomKey)
        }
        
        isRandom = standard.bool(forKey: isRandomKey)
    }
    
    func saveRandomToggleState(){
        UserDefaults.standard.set(Bool(isRandom), forKey: isRandomKey)
    }
    
    func saveDateState(){
        let standard = UserDefaults.standard
        let selectedDateValue = selectedDate.timeIntervalSinceReferenceDate
        standard.set(selectedDateValue, forKey: selectedDateKey)
    }
    
    
    var body: some View {
        VStack {
            Toggle(isOn: $isRandom) {
                Text("Random image")
            }.padding(.horizontal)
                .onChange(of: isRandom) {
                    saveRandomToggleState()
                }
            HStack {
                DatePicker(
                    selection: $selectedDate,
                    in: ...Date(),
                    displayedComponents: .date,
                    label: {
                        Text("Date")
                    }
                ).disabled(isRandom)
                    .onChange(of: selectedDate) {
                        saveDateState()
                    }
                Button(action: {
                    self.selectedDate = Date()
                }) {
                    Image(systemName: "calendar.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }.padding(.horizontal)
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
            
        }.onAppear(perform: {
            initView()
            if shouldPerformInitialSearch {
                search()
                shouldPerformInitialSearch = false
            }
        })
    }
}

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

#Preview {
    HomeView()
}
