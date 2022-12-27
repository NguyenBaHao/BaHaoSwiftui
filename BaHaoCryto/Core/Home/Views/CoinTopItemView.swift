//
//  CoinTopItemView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct CoinTopItemView: View {
    let coin: CoinModel
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("\(coin.symbol.uppercased())")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text((coin.priceChangePercentage24H ?? 0) >= 0 ? "+" : "-")
                        .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
                }
                Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                    .fontWeight(.bold)
                    .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            }
        }
        .frame(width:UIScreen.main.bounds.width / 3.1, height: 100)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.accent, lineWidth: 1)
        }
    }
}

struct CoinTopItemView_Previews: PreviewProvider {
    static var previews: some View {
        CoinTopItemView(coin: dev.coin)
    }
}
