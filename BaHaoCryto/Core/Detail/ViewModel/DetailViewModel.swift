//
//  DetailViewModel.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 27/12/2022.
//

import Foundation
import Combine
import SwiftUI
class DetailViewModel: ObservableObject{
    
    @Published var overViewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var wedsiteURL: String? = nil
    @Published var redditURL: String? = nil

    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
        
            .sink { [weak self] (returnedArray) in
                self?.overViewStatistics = returnedArray.overview
                self?.additionalStatistics = returnedArray.additional
            }
            .store(in: &cancellables)
        coinDetailService.$coinDetail
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.wedsiteURL = returnedCoinDetails?.links?.homepage?.first
               // self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]){
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricechange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Giá Hiện Tại", value: price, percentageChange: pricechange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let maketCapChance = coinModel.marketCapChangePercentage24H
        let  marketCapstat = StatisticModel(title: "Vốn Hóa Thị Trường", value: marketCap, percentageChange: maketCapChance)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let Volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Tổng Khối Lượng", value: Volume)
        
        let overviewArray: [StatisticModel] = [
            rankStat, priceStat, marketCapstat,volumeStat
        ]
        let hasding = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing", value: hasding)
        
        let additionalArray: [StatisticModel] = [hashingStat]
        return (overviewArray, additionalArray)
    }
    
}
