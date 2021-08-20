//
//  ChartVIew.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 20/8/21.
//

import SwiftUI

struct ChartVIew: View {
    let data : [Double]
    let minY: Double
    let maxY: Double
    @State private var percentage: CGFloat = 0
    var body: some View {
        VStack{
            chartView
                .frame(height: 200)
                .background(chartLines)
                .overlay(chartValues, alignment: .leading)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.linear(duration: 3.0)){
                    percentage = 1.0
                }
            }
        }
    }
}

func getLineColor(last: Double, first: Double) -> Color{
    let priceChange = last - first
    return priceChange > 0 ? Color.green : Color.red
}

extension ChartVIew{
    private var chartView: some View{
        GeometryReader { geometry in
            Path{ path in
                for index in data.indices{
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: percentage)
            .stroke(getLineColor(last: data.last ?? 0, first: data.first ?? 0), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: getLineColor(last: data.last ?? 0, first: data.first ?? 0), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
            .shadow(color: getLineColor(last: data.last ?? 0, first: data.first ?? 0), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
        }
    }
    
    private var chartLines: some View{
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartValues: some View{
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            let middle = (maxY + minY) / 2
            Text(middle.formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
}
