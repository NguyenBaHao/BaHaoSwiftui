//
//  ContentView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm : HomeViewModel
        var body: some View {
        Group{
            if vm.userSession == nil{
                Login()
            }else{
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HomeViewModel())
    }
}
