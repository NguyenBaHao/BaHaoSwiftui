//
//  StatisticView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 27/12/2022.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    var body: some View {
        HStack{
            Text(stat.title)
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            Spacer()
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: .init(title: "1", value: "1"))
    }
}
