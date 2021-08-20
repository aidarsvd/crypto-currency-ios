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
        NavigationView{
            VStack(alignment: .center){
                Text("Live Price")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                SearchBar(searchText: $viewModel.searchText)
                
                FilterView(
                    isLoading: $viewModel.isLoading,
                    onPriceSort:{self.priceSort()},
                    onRankSort: {self.rankSort()},
                    onUpdate: {self.fetchCoins()}
                )
                    
                
                ScrollView(showsIndicators: false){
                    ForEach(viewModel.prices){ coin in
                        NavigationLink(
                            destination: CoinDetailView(),
                            label: {
                                CoinItemView(model: coin)
                            })
                    }
                }
                .padding(.top, 16)
            }
        }
        .onAppear(perform: fetchCoins)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func priceSort(){
        print("Hello")
    }
    
    private func fetchCoins(){
        viewModel.fetchList()
    }
    
    private func rankSort(){
        print("Test")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        
        ContentView()
            .preferredColorScheme(.dark)
    }
}
