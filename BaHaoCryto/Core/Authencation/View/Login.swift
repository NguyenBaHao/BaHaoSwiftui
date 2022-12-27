//
//  Login.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var password = ""
    @State var visible: Bool = false
    @State var alert = false
    @State var error = ""
    @EnvironmentObject var vm : HomeViewModel
    var body: some View {
        ZStack{
            ZStack(alignment: .topTrailing) {
            GeometryReader{ _ in
                
                VStack(spacing: 22.0){
                   Image("ImageCryto")
                        .resizable()
                        .frame(width: 200,height: 200)
                        .clipped()
                        .cornerRadius(200)
                        .padding(.bottom)
                    Text("Đăng nhập vào tài khoản")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemBlue))
                    TextField("Email", text: self.$email)
                        .padding()
                        .disableAutocorrection(true)
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color(.systemBlue) : Color.gray, lineWidth: 2))
                    
                    HStack{
                        VStack{
                            if self.visible{
                                TextField("Password", text: self.$password)
                            }
                            else{
                                SecureField("PassWord", text: self.$password)
                                
                            }
                        }
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(visible ? Color(.systemBlue) : Color.gray)
                        }
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.systemBlue) : Color.gray, lineWidth: 2))
                    
                    HStack(spacing: 15) {
                        Spacer()
                        Button(action: {
                            vm.reset(withEmail: email)
                        })
                        {
                            Text("Quên Mật Khẩu")
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                        }
                    }
                    Button(action: {
                        vm.login(withEmail: email, password: password)
                        self.verify()
                    }) {
                        Text("Đăng nhập")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(12)
                    .padding(.top)
                }
                .padding(.horizontal)
            }
            NavigationLink(destination: Register()){
                Text("Đăng ký")
                    .fontWeight(.bold)
                    .foregroundColor(Color(.systemBlue))
            }
            .padding()
        }
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    func verify(){
        if self.email != "" && self.password != "" {
        }
        else{
            self.error = "Vui lòng điền đầy đủ nội dung"
            self.alert.toggle()
        }
    }
}
struct Login_Previews: PreviewProvider {
        static var previews: some View {
            Login()
        }
    }
