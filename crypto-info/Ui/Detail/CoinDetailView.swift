//
//  CoinDetailView.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import SwiftUI
import Kingfisher

struct CoinDetailView: View {
    @ObservedObject private var viewModel = DetailViewModel()
    var id: String
    var body: some View {
        ScrollView(showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/){
            VStack {
                ChartVIew(data: viewModel.detailData.market_data.sparkline_7d.price, minY: viewModel.detailData.market_data.sparkline_7d.price.min() ?? 0, maxY: viewModel.detailData.market_data.sparkline_7d.price.max() ?? 0)
            }
        }
        .onAppear{
            viewModel.fetchDetail(id: self.id)
        }
        .navigationTitle(viewModel.detailData.name)
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarTrailing){
                KFImage(URL(string: viewModel.detailData.image.small))
                    .resizable()
                    .frame(width: 25, height: 25)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)

            }
        })
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(id: "")
    }
}
