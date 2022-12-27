//
//  DangKy.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct Register: View {
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var repassword = ""
    @State var visible: Bool = false
    @State var revisible: Bool = false
    @State var alert = false
    @State var error = ""
    @EnvironmentObject var vm: HomeViewModel
    var body: some View {
        ZStack(alignment: .topLeading){
            GeometryReader{ _ in
                VStack(spacing: 25) {
                    Text("Đăng ký tài khoản")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemBlue))
                    TextField("Họ và tên:", text: self.$fullName)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.fullName != "" ? Color(.systemBlue) : Color.black, lineWidth: 2))
                    TextField("Tên tài khoản: Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color(.systemBlue) : Color.black, lineWidth: 2))
                    HStack(spacing: 15) {
                        VStack{
                            if self.visible{
                                TextField("Password", text: self.$password)
                            }else{
                                SecureField("Password", text: self.$password)
                            }
                        }
                        Button(action: {
                            self.visible.toggle()
                            
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(visible ? Color(.systemBlue) : Color.black)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.systemBlue) : Color.black, lineWidth: 2))
                    HStack(spacing: 15) {
                        if self.revisible{
                            TextField("nhập lại mật khẩu", text: $repassword)
                        }
                        else{
                            SecureField("nhập lại mật khẩu", text: $repassword)
                        }
                        Button(action: {self.revisible.toggle()}) {
                            Image(systemName: self.revisible ? "eys.slash.fill" : "eye.fill")
                                .foregroundColor(revisible ? Color(.systemBlue) : Color.black)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.repassword != "" ? Color(.systemBlue) : Color.black, lineWidth: 2))
                    Button {
                        if self.password == self.repassword{
                            vm.register(withEmail: email, password: password, repassword: repassword, fullName: fullName)
                        }else{
                            self.error = "Mật khẩu không khớp"
                            self.alert.toggle()
                        }
                    } label: {
                        Text("Đăng ký")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .padding(.top)
                    
                }
                .padding(.horizontal)
            }
            if self .alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
}
struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
