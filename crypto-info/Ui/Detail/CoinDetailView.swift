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
        
        if viewModel.isLoading {
            ProgressView()
                .onAppear{
                    viewModel.fetchDetail(id: self.id)
                }
        }else{
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
                    
                    if !viewModel.detailData.description.text.isEmpty{
                        Text(viewModel.detailData.description.text)
                            .padding(.horizontal, 16)
                            .lineLimit(isTextExpanded ? nil : 5)
                        
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
                    
                    Text("Market Data")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .padding()

                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Rank")
                                    .bold()

                                Text("\(viewModel.detailData.market_cap_rank)")
                                    .bold()
                            }
                            .frame(maxHeight: 100, alignment: .top)

                            Spacer()
                            
                            VStack(alignment: .leading){
                                Text("Current price")
                                    .bold()
                                let currentPrice = viewModel.detailData.market_data.current_price.usd.formattedWithAbbreviations()
                                Text(currentPrice)
                                    .bold()

                                HStack{
                                    Image(systemName: getImage(percent: Int(viewModel.detailData.market_data.price_change_percentage_24h)))

                                        .foregroundColor(getColor(percent: Int(viewModel.detailData.market_data.price_change_percentage_24h)))

                                    Text("\(String(viewModel.detailData.market_data.price_change_percentage_24h )) %")
                                        .foregroundColor(getColor(percent: Int(viewModel.detailData.market_data.price_change_percentage_24h)))
                                }
                            }
                            .frame(maxHeight: 100, alignment: .top)

                        }
                        .padding(.horizontal, 16)
                        
                        HStack{
                            VStack(alignment: .leading){
                                Text("Highest today")
                                    .bold()
                                let highPrice = viewModel.detailData.market_data.high_24h.usd.formattedWithAbbreviations()
                                Text("$\(highPrice)")
                                    .bold()
                            }
                            .frame(maxHeight: 100, alignment: .top)

                            Spacer()
                            
                            VStack(alignment: .leading){
                                Text("Lowest today")
                                    .bold()

                                let lowest = viewModel.detailData.market_data.high_24h.usd.formattedWithAbbreviations()

                                Text("$\(lowest)")
                                    .bold()
                            }
                            .frame(maxHeight: 100, alignment: .top)
                        }
                        .padding(16)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
}
