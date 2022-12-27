//
//  UserService.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 27/12/2022.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService{
    func fetchUser(with uid: String, completion: @escaping(User)-> Void){
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                
                guard let user = try? snapshot.data(as: User.self) else {return}
                completion(user)
                
            }
    }
}
