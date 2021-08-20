//
//  CoinItemView.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import SwiftUI
import Kingfisher

struct CoinItemView: View {
    
    var model: Crypto?
    var body: some View {
        VStack{
            HStack{
                Text(String(model?.market_cap_rank ?? 0))
                    .bold()
                    .padding(.trailing, 12)
                    .foregroundColor(Color("theme_reverse"))
                
                
                KFImage(URL(string: model?.image ?? ""))
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
                Text(model?.name ?? "")
                    .bold()
                    .foregroundColor(Color("theme_reverse"))

                Spacer()
                VStack(alignment: .trailing){
                    Text("$ \(String(model?.current_price ?? 0))")
                        .foregroundColor(Color("theme_reverse"))

                    HStack{
                        Image(systemName: getImage(percent: Int(model!.price_change_percentage_24h)))
                            .foregroundColor(getColor(percent: Int(model!.price_change_percentage_24h)))
                        Text("\(String(model?.price_change_percentage_24h ?? 0)) %")
                            .foregroundColor(getColor(percent: Int(model!.price_change_percentage_24h)))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

struct CoinItemView_Previews: PreviewProvider {
    static var previews: some View {
        CoinItemView(model: Crypto(id: "bitcoin", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", current_price: 20000.322, price_change_percentage_24h: 12, market_cap_rank: 1))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}


func getColor(percent: Int) -> Color{
    if percent > 0 {
        return .green
    }else{
        return .red
    }
}

func getImage(percent: Int) -> String{
    if percent > 0 {
        return "arrow.up.right"
    }else{
        return "arrow.down.left"
    }
}
