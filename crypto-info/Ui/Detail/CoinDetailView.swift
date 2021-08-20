//
//  CoinDetailView.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import SwiftUI

struct CoinDetailView: View {
    @ObservedObject private var viewModel = DetailViewModel()
    var id: String
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                viewModel.fetchDetail(id: self.id)
            }
            .navigationTitle(viewModel.detailData.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(id: "")
    }
}
