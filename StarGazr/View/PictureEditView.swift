//
//  PictureEditView.swift
//  StarGazr
//
//  Created by Patrick Schwartzbach on 28/02/2024.
//

import SwiftUI

struct PictureEditView: View {
    @State var apod: APODModel
    @State var title = ""
    @State var description = ""
    
    @Environment(FavoritesViewModel.self) var favourites
    @Environment(\.verticalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $title)
            }
            Section(header: Text("Description")) {
                if sizeClass == .compact {
                    TextEditor(text: $description)
                        .frame(height: 200)
                } else {
                    TextEditor(text: $description)
                        .frame(height: 400)
                }
            }
            
            Button(action: save, label: {
                Text("save")
            })
        }
        .onAppear(perform: initView)
        .navigationTitle("Editing: \(apod.title)")
        
    }
    
    func save() {
        apod.title = title
        apod.explanation = description
        
        favourites.update(APOD: apod)
        presentationMode.wrappedValue.dismiss()
    }
    
    func initView() {
        title = apod.title
        description = apod.explanation
    }
}

#Preview {
    PictureEditView(apod: defaultModel()).environment(FavoritesViewModel())
    
}
