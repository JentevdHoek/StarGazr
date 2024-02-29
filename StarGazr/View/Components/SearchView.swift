//
//  SearchView.swift
//  StarGazr
//
//  Created by Jente van der Hoek on 28/02/2024.
//

import SwiftUI

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
    
    func saveRandomToggleState(){
        UserDefaults.standard.set(Bool(isRandom), forKey: isRandomKey)
    }
    
    func saveDateState(){
        let standard = UserDefaults.standard
        let selectedDateValue = selectedDate.timeIntervalSinceReferenceDate
        standard.set(selectedDateValue, forKey: selectedDateKey)
    }
    
    func initialise() {
        let standard = UserDefaults.standard
        
        if standard.object(forKey: selectedDateKey) == nil {
            let selectedDateValue = selectedDate.timeIntervalSinceReferenceDate
            standard.set(selectedDateValue, forKey: selectedDateKey)
            standard.synchronize()
        }
        
        selectedDate = Date(timeIntervalSinceReferenceDate: standard.double(forKey: selectedDateKey))
        
        if standard.object(forKey: isRandomKey) == nil {
            standard.set(isRandom, forKey: isRandomKey)
        }
        
        isRandom = standard.bool(forKey: isRandomKey)
        
        if shouldPerformInitialSearch {
            search()
            shouldPerformInitialSearch = false
        }
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
                Spacer()
                DatePicker(
                    selection: $selectedDate,
                    in: ...Date(),
                    displayedComponents: .date,
                    label: {}
                ).disabled(isRandom)
                    .labelsHidden()
                .onChange(of: selectedDate) {
                    saveDateState()
                }
                Spacer()
                Button(action: {
                    self.selectedDate = Date()
                }) {
                    Image(systemName: "calendar.circle.fill")
                        .font(.title)
                        .foregroundColor(isRandom ? .gray : .blue)
                }.disabled(isRandom)
                Spacer()
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
            initialise()
        })
    }
}
