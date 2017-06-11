//
//  Todo.swift
//  CodableAlamofire
//
//  Created by Nikita Ermolenko on 10/06/2017.
//  Copyright © 2017 Nikita Ermolenko. All rights reserved.
//

import Foundation

struct Todo: Decodable {
    
    var id: Int?
    var title: String
    var userId: Int
    var body: String
}
