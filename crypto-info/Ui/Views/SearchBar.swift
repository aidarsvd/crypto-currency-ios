//
//  SearchBar.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search by word", text: $searchText)
                .disableAutocorrection(true)
        }
        .padding(12)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color("theme_reverse"), lineWidth: 1)
        )
        .padding()
    }
}
