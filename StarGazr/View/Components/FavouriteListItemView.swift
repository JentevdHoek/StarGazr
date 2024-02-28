//
//  FavouriteListItemView.swift
//  StarGazr
//
//  Created by Patrick Schwartzbach on 28/02/2024.
//

import SwiftUI

struct FavouriteListItemView: View {
    var body: some View {
        NavigationLink(destination: PictureDetailView())
        {
            HStack{
                Image("test")
                    .resizable()
                    .frame(width: 50, height: 50)
                 Text("Shades of Night")
            }
        }
            
    }
}

#Preview {
    FavouriteListItemView()
}
