//
//  Model.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 22.09.2021.
//

import Foundation

struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
