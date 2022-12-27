//
//  HomeView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
            ZStack{
                Color.theme.background
                    .ignoresSafeArea()
                VStack{
                    SearchBarView(searchText: $vm.searchText)
                    topCoin
                    columTitles
                    allcoinlist
                    Spacer(minLength: 0)
                }
            }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            HomeView()
                .environmentObject(dev.homeVM)
    }
}
extension HomeView{
    private var allcoinlist: some View{
        ZStack{
                ScrollView{
                    ForEach(vm.allCoins){ coin in
                        NavigationLink {
                            DetailView(coin: coin)
                        } label: {
                            CoinRowView(coin: coin, showHoldingsColumn: false)
                                .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                            
                        }

                    }
                }
                .listStyle(PlainListStyle())
            }
    }
    private var columTitles: some View{
        HStack{
            Text("Coin")
            Spacer()
            HStack{
                Text("Giá gần nhất")
                Image(systemName: "chevron.down")
                    .rotationEffect(Angle(degrees: vm.sortoption == .price  ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortoption = vm.sortoption == .price ? .price : .priceReversed
                }
            }
            HStack{
                Text("Thay đổi 24h")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Button(action: {
                    withAnimation(.linear(duration: 1.0)){
                        vm.reloadData()
                    }
                }) {
                    Image(systemName: "goforward")
                }
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
            }
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    private var topCoin: some View{
        ScrollView(.horizontal){
            HStack{
                ForEach(vm.allCoins){ coin in
                    NavigationLink {
                        DetailView(coin: coin)
                    } label: {
                        CoinTopItemView(coin: coin)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
