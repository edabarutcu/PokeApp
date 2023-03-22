//
//  ApiModel.swift
//  PokeApp
//
//  Created by Eda Barutçu on 21.03.2023.
//

import Foundation

struct ApiModel: Codable {
    let count: Int
    let next: String
    let results: [Result]
    
    init(count: Int, next: String, results: [Result]) {
        self.count = count
        self.next = next
        self.results = results
    }
    
}
