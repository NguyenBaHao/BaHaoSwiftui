//
//  ErrorView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct ErrorView: View {
    @Binding var alert: Bool
    @Binding var error: String
    var body: some View {
        GeometryReader{ _ in
            VStack(alignment: .center){
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Text("Lỗi:")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        Text(self.error)
                            .foregroundColor(Color.black)
                            .padding(.top)
                        
                        Button(action: {
                            self.alert.toggle()
                        }) {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 120)
                        }
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                        .padding(.top, 25)
                    }
                    .padding(.vertical, 25)
                    .frame(width: UIScreen.main.bounds.width - 70)
                    .background(Color.white)
                    .cornerRadius(15)
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(alert: .constant(false), error: .constant("dasd"))
    }
}
