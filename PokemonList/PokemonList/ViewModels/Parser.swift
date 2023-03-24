//
//  Parser.swift
//  PokemonList
//
//  Created by Eda Barutçu on 21.03.2023.
//

import Foundation

struct Parser {
    
    let host = "https://pokeapi.co/api/v2/"
    
    func parsePokemonList(endpoint : String = "pokemon/", urlString: String?, onSuccess: @escaping (PokemonListData) -> Void, onError: @escaping (Error) -> Void) {
        var url : URL?
        if let myUrl = urlString{
            url = URL(string: myUrl)
        } else {
            url = URL(string: host+endpoint+"?limit=40")
        }
        if urlString == "NO" {
            return
        }
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if let errore = error {
                onError(errore)
                return
            }
            if let myData = data{
                do {
                    let result = try JSONDecoder().decode(PokemonListData.self, from: myData)
                    onSuccess(result)
                } catch {
                    print("Errore durante la conversione")
                }
            }
        }.resume()
    }
    
    func parsePokemonDetails(named : String, onSuccess: @escaping (PokemonDetailsData) -> Void, onError: @escaping(Error) -> Void) {
        let urlString = host + "pokemon/" + named
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url){
            data, response, error in
            if let errore = error {
                onError(errore)
                return
            }
            if let myData = data {
                do {
                    let result = try JSONDecoder().decode(PokemonDetailsData.self, from: myData)
                    onSuccess(result)
                }catch {
                    print("Errore durante la conversione! \(error.localizedDescription)")
                    return
                }
            }
        }.resume()
    }
}
