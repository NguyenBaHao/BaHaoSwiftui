//
//  BaHaoCrytoApp.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI
import Firebase
@main
struct BaHaoCrytoApp: App {
    @StateObject var vm = HomeViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(vm)
        }
    }
}
