//
//  DetailView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    private let columns: [GridItem] = [GridItem(.flexible())]
    init(coin: CoinModel) {
        _vm  = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                Text("")
                    .frame(height: 150)
                
                Text("Thông tin")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                HStack(spacing: 4.0){
                    CoinImageView(coin: vm.coin)
                        .frame(width: 35, height: 35)
                    Text("\(vm.coin.name.uppercased())")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                LazyVGrid(columns: columns, alignment: .leading, spacing: 40, pinnedViews: []) {
                    ForEach(vm.overViewStatistics){ stats in
                        StatisticView(stat: stats)
                }
                }
                HStack{
                    Text("Khám Phá")
                        .font(.headline)
                        .foregroundColor(Color.theme.secondaryText)
                    Spacer()
                    if let wedsiteURL = vm.wedsiteURL, let url = URL(string: wedsiteURL){
                        Link("\(wedsiteURL)", destination: url)
                            .foregroundColor(.yellow)
                    }
                }
                    Text("Giới Thiệu")
                        .font(.headline)
                        .foregroundColor(Color.theme.secondaryText)
                    Divider()
                ZStack{
                    if let coinDescription = vm.coinDescription, !coinDescription.isEmpty{
                        Text(coinDescription)
                    }
                }
            }
        }
        .padding()
        .navigationTitle(vm.coin.symbol.uppercased() + ("/USDT"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(coin: dev.coin)
        }
    }
}
