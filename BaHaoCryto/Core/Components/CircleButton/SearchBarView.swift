//
//  SearchBarView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack{
            NavigationLink {
                SwiftUIView()
            } label: {
                Image(systemName: "person")
                    .font(.system(size: 35, weight: .bold))
            }
            .overlay(
                RoundedRectangle(cornerRadius: 64)
                    .stroke(Color.theme.accent, lineWidth: 2)
            )
            HStack{
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.theme.secondaryText)
                TextField("Tim kiem", text: $searchText)
                    .foregroundColor(Color.theme.accent)
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "xmark")
                            .padding()
                            .foregroundColor(Color.theme.accent)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                UIApplication.shared.endEditting()
                                searchText = ""
                            }
                        ,alignment: .trailing
                    )
            }
            .font(.headline)
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent, radius: 2, x: 0, y: 0)
            }
            Button(action: {}) {
                Image(systemName: "bell.badge")
                    .font(.system(size: 27, weight: .bold))
                    .foregroundColor(Color.theme.accent)
                    .padding(.horizontal,5)
            }
        }
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SearchBarView(searchText: .constant(""))
        }
    }
}
