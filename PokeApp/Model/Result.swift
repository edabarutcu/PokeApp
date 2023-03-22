//
//  Result.swift
//  PokeApp
//
//  Created by Eda Barutçu on 21.03.2023.
//

import Foundation

struct Result: Codable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
        
    }
}
