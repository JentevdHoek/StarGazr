//
//  PictureEditView.swift
//  StarGazr
//
//  Created by Patrick Schwartzbach on 28/02/2024.
//

import SwiftUI

struct PictureEditView: View {
    @State var apod: APODModel
    @Environment(FavoritesViewModel.self) var favourites
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $apod.title)
            }
            Section(header: Text("Description")) {
                TextEditor(text: $apod.explanation)
                    .frame(height: 500)
            }
            
            Button(action: save, label: {
                Text("save")
            })
        }.navigationTitle("Editing: \(apod.title)")
        
    }
    
    func save() {
        favourites.update(APOD: apod)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    PictureEditView(apod: defaultModel()).environment(FavoritesViewModel())
    
}
