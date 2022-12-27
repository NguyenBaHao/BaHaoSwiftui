//
//  SwiftUIView.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI
struct SwiftUIView: View {
    @EnvironmentObject var vm: HomeViewModel
    @State var showldShowImagePicker = false
    @State var image: UIImage?
    var body: some View {
        if let user = vm.currentUser{
            VStack{
                HStack{
                    Button {
                        showldShowImagePicker.toggle()
                    } label: {
                        VStack{
                            if let image = self.image{
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            }
                            else{
                                Image(systemName: "person")
                                    .font(.system(size: 65))
                                    .padding()
                                    .foregroundColor(Color.theme.accent)
                            }
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 65)
                            .stroke(Color.theme.accent, lineWidth: 2)
                    )
                    VStack(alignment: .leading, spacing: 15){
                        Text(user.fullName)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color.theme.accent)
                        Text("\(user.email)")
                            .foregroundColor(Color.theme.secondaryText)
                    }
                    Spacer()
                }
                Spacer()
                Button {
                    vm.signOut()
                } label: {
                    Text("Đăng Xuất")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.background)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 70)
                        .background{
                            RoundedRectangle(cornerRadius: 15,style: .continuous)
                                .fill(Color.theme.accent.opacity(0.8))
                            
                        }
                }
            }
            .padding()
            .fullScreenCover(isPresented: $showldShowImagePicker, onDismiss: nil, content: {
                ImagePicker(image: $image)
            })
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
            .environmentObject(HomeViewModel())
    }
}
