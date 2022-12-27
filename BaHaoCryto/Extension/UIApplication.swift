//
//  SwiftUIView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI
import Foundation
extension UIApplication{
    func endEditting(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
