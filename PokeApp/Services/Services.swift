//
//  Services.swift
//  PokeApp
//
//  Created by Eda Barutçu on 21.03.2023.
//

import Foundation

class Services {
    
    static let shared = Services()
    
    private let pokemonsURL = "https://pokeapi.co/api/v2/pokemon/?limit=20&offset=20"
    private let abRequest = ABRequest()
    
    var lastResult: ApiModel?
    
    func getPokemons(completion: (([ResultViewModel]?, _ hasError: Bool) -> ())? = nil) {
        abRequest.send(url: pokemonsURL) { (data) in
            
            guard let jsonData = data else{
                completion?(nil, true)
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let api = try decoder.decode(ApiModel.self, from: jsonData)
                self.lastResult = api
                
                let group = DispatchGroup()
                var results = [ResultViewModel]()
                
                api.results.forEach { result in
                    
                    group.enter()
                    let resultViewModel = ResultViewModel(result: result)
                    
                    resultViewModel.onDetailLoad = {
                        results.append(resultViewModel)
                        group.leave()
                    }
                }
                
                group.notify(queue: DispatchQueue.global()) {
                    completion?(results, false)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
