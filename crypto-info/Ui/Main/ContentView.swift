//
//  ContentView.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State var search: String = ""
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Text("Live Price")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Search by word", text: $search)
                    .padding(16)

                ScrollView(showsIndicators: false){
                    ForEach(viewModel.fetchedCoins){ coin in
                        NavigationLink(
                            destination: CoinDetailView(),
                            label: {
                                Text("\(coin.id)")
                            })
                    }
                }
            }
        }
        .onAppear(perform: fetchCoins)
        .navigationBarHidden(true)
    }
    
    private func fetchCoins(){
        viewModel.fetchList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
