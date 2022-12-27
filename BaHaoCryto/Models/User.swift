//
//  User.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 27/12/2022.
//

import FirebaseFirestoreSwift
import SwiftUI
struct User: Identifiable, Decodable{
    @DocumentID var id: String?
    let fullName: String
    let email: String
}
