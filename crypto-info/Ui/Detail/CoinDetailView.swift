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
    @State private var isTextExpanded = false
    var id: String
    var body: some View {
        ScrollView(showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/){
            VStack(alignment: .leading){
                ChartVIew(data: viewModel.detailData.market_data.sparkline_7d.price, minY: viewModel.detailData.market_data.sparkline_7d.price.min() ?? 0, maxY: viewModel.detailData.market_data.sparkline_7d.price.max() ?? 0)
                    .padding()
               
                Text("Overview")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding()
                Divider()
                    .padding(.horizontal, 16)
                
                Text(viewModel.detailData.description.text)
                    .padding(.horizontal, 16)
                    .lineLimit(isTextExpanded ? nil : 3)
                
                Button(action: {
                    withAnimation(.easeInOut){
                        isTextExpanded.toggle()
                    }
                }, label: {
                    Text(isTextExpanded ? "Read less" : "Read more")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.caption)
                        .bold()
                })
                .padding()

            }
        }
        .onAppear{
            viewModel.fetchDetail(id: self.id)
        }
        .navigationTitle(viewModel.detailData.name)
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
        CoinDetailView(id: "bitcoin")
    }
}
