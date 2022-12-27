//
//  CoinRowView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    var body: some View {
        HStack( spacing: 0.0){
            Text("\(coin.rank)")
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 20, alignment: .leading)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30, alignment: .leading)
            Text("\(coin.symbol.uppercased())/USD")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
            Spacer()
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                    .foregroundColor(Color.theme.accent)
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.vertical, 10)
                .frame(width: 70)
                .background((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red).opacity(0.9)
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .padding(.vertical,15)
        .font(.subheadline)
        .padding(.horizontal)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
    }
}
