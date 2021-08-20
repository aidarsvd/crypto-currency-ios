//
//  FilterView.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 20/8/21.
//

import SwiftUI

struct FilterView: View {
    
    @State var isPriceSorted = false
    @State var isRankSorted = false
    @Binding var isLoading: Bool
    var onPriceSort: () -> Void
    var onRankSort: () -> Void
    var onUpdate: () -> Void

    
    var body: some View {
        
        HStack{
            
            Button(action: {
                self.onPriceSort()
                isPriceSorted.toggle()
            }, label: {
                Text("Price")
                    .foregroundColor(Color("theme_reverse"))
                Image(systemName: isPriceSorted ? "arrow.down" : "arrow.up")
                    .foregroundColor(Color("theme_reverse"))

            })
            
            Spacer()
            
            Button(action: {
                isRankSorted.toggle()
                self.onRankSort()
            }, label: {
                Text("Rank")
                    .foregroundColor(Color("theme_reverse"))
                Image(systemName: isRankSorted ? "arrow.down" : "arrow.up")
                    .foregroundColor(Color("theme_reverse"))

            })
            
            Spacer()

            
            Button(action: {
                withAnimation(.linear(duration: 2.0)){
                    self.onUpdate()
                }
            }, label: {
                Image(systemName: "goforward")
                    .foregroundColor(Color("theme_reverse"))
            })
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0), anchor: .center)
                
        }
        .padding()
    }
}
