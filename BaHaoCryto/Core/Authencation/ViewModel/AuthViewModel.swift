//
//  AuthViewModel.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    
    init(){
        self.userSession = Auth.auth().currentUser
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
}
