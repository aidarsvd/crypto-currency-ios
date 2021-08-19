//
//  SearchBar.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import SwiftUI

struct SearchBar: View {
    
    @State var searchText = ""
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            
            TextField("Search by word", text: $searchText)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color("theme_reverse"), lineWidth: 1)
        )
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
            .preferredColorScheme(.light)
    }
}
