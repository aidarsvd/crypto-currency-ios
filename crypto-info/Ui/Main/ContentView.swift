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
                
                HStack{
                    Button(action: {
                        withAnimation(.linear(duration: 2.0)){
                            viewModel.fetchList()
                        }
                        
                    }, label: {
                        Image(systemName: "goforward")
                            .foregroundColor(Color("theme_reverse"))
                    })
                    .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)
                        
                }
                
                ScrollView(showsIndicators: false){
                    ForEach(viewModel.prices){ coin in
                        NavigationLink(
                            destination: CoinDetailView(),
                            label: {
                                CoinItemView(model: coin)
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
            .preferredColorScheme(.light)
    }
}
