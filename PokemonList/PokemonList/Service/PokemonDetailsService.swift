//
//  PokemonDetailsService.swift
//  PokemonList
//
//  Created by Eda Barutçu on 21.03.2023.
//

import Foundation

class PokemonDetailsService {
    
    private static let pokemonDetailsSections : [String] = ["Ability",
                                                            "Basic experience",
                                                            "Species",
                                                            "Featured in games",
                                                            "Statistics",
                                                            "Types"    ]
    
    public static func getSections() -> [String] {
        return pokemonDetailsSections
    }
}
