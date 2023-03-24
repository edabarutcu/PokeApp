//
//  PokemonData.swift
//  PokemonList
//
//  Created by Eda Barutçu on 21.03.2023.
//

import Foundation

class PokemonData : Codable {
    var name : String?
    var url : String?
}

class PokemonListData : Codable {
    var count : Int?
    var next : String?
    var previous : String?
    var results : [PokemonData]?
}
