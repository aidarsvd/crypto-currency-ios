//
//  ContentView.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MainViewModel()
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear{
                viewModel.fetchList()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
