//
//  HomeViewModel.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI
import Combine
import Firebase
class HomeViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var service = UserService()
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] =  []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortoption: SortOption = .price
    
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption{
        case  price, priceReversed
    }
    init(){
        addSubscribers()
        
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    func addSubscribers(){
        
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortoption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
//            .map { (text, startingCoins) -> [CoinModel] in
//                guard !text.isEmpty else {
//                    return startingCoins
//                }
//                let lowecasedText = text.lowercased()
//
//                return startingCoins.filter { (coin) in
//                    return coin.name.lowercased().contains(lowecasedText) ||  coin.symbol.lowercased().contains(lowecasedText) || coin.id.lowercased().contains(lowecasedText)
//                }
//            }
            .sink { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel]{
            guard !text.isEmpty else {
                return coins
            }
            let lowecasedText = text.lowercased()
            
            return coins.filter { (coin) in
                return coin.name.lowercased().contains(lowecasedText) ||  coin.symbol.lowercased().contains(lowecasedText) || coin.id.lowercased().contains(lowecasedText)
            }
        }
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel],sort: SortOption )-> [CoinModel]{
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]){
        switch sort{
        case.price:
             coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case.priceReversed:
             coins.sort(by: {$0.currentPrice < $1.currentPrice})
            //            return coins.sorted { (coin1, coin2) in
            //                return coin1.rank < coin2.rank
            //           }
        }
    }
    
    
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            print("DEBUGdid log user in")
        }
    }
    
    func register(withEmail email: String, password: String, repassword: String, fullName: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                print("DEBUG: Failed to register with error\(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            
            let data = ["email" : email,
                        "fullName": fullName,
                        "uid": user.uid]
            Firestore.firestore().collection("users").document(user.uid)
                .setData(data){ _ in
                    print("Debug: did upload user data..")
                }
        }
    }
    func reset(withEmail email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error{
                print("DEBUG:\(error.localizedDescription)")
                return
            }
     
        }
    }
    func signOut(){
        userSession = nil
        try? Auth.auth().signOut()
    }
    func fetchUser(){
        guard let uid = self.userSession?.uid else {return}
        
        service.fetchUser(with: uid) { user in
            self.currentUser = user
        }
    }
}
