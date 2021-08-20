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
        if viewModel.launchLoading {
            ProgressView()
                .onAppear(perform: fetchCoins)
        }else{
            NavigationView{
                VStack(alignment: .center){
                    SearchBar(searchText: $viewModel.searchText)
                    
                    FilterView(
                        isLoading: $viewModel.isLoading,
                        onRankSort: {self.rankSort()},
                        onUpdate: {self.fetchCoins()}
                    )
                        
                    
                    ScrollView(showsIndicators: false){
                        ForEach(viewModel.prices){ coin in
                            NavigationLink(
                                destination: CoinDetailView(id: coin.id),
                                label: {
                                    CoinItemView(model: coin)
                                })
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    
    }
    private func fetchCoins(){
        viewModel.fetchList()
    }
    
    private func rankSort(){
        viewModel.prices.reverse()
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
