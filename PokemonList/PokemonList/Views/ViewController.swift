//
//  ViewController.swift
//  PokemonList
//
//  Created by Eda Barutçu on 22.03.2023.
//

import UIKit

//MARK: - ViewControllerProtocol
protocol ViewControllerProtocol : AnyObject {
    func watchPokemonDetails(_ pokemonDetails: PokemonDetailsData)
}

class ViewController: UIViewController {

    private var pokemons = [PokemonData]()
    private var nextURL : String?
    private let parser = Parser()
    private var isFree : Bool = true
    var tableView = UITableView(frame: UIScreen.main.bounds)
    
    weak var delegate : ViewControllerProtocol?
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        self.title = "Pokemon List"
        fetchPokemons()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(PokemonListTableViewCell.self, forCellReuseIdentifier: "PokemonListCell")
        view.addSubview(tableView)
        
    }
    
    private func fetchPokemons() {
        
        isFree = false
        parser.parsePokemonList(urlString: nextURL, onSuccess: {
            data in
            if let url = data.next {
                self.nextURL = url
            } else {
                self.nextURL = "NO"
            }
            for elem in data.results! {
                self.pokemons.append(elem)
            }
            print("COUNT: \(self.pokemons.count) ")
            print("COUNT: \(self.nextURL!)")
            DispatchQueue.main.sync{self.tableView.reloadData()}
            self.isFree = true
        }, onError: {
            error in
            print(error)
            self.isFree = true
        })
        print("DIM: \(pokemons.count) ")
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListCell") as? PokemonListTableViewCell {
            if let pokemonName = pokemons[indexPath.item].name {
                cell.setup(pokemonName, imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.item+1).png")!)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected pokemon: \(pokemons[indexPath.item].name!) ")
        print("URL: \(pokemons[indexPath.item].url!)")
        parser.parsePokemonDetails(named: pokemons[indexPath.item].name!, onSuccess: {
            data in
            print("\(data.name!) fetched details")
            DispatchQueue.main.sync {
                self.delegate?.watchPokemonDetails(data)
            }
          //  I should launch the details view
        }, onError: { error in
            print("[PARSER] error during the request! \(error.localizedDescription)")
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

private extension ViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.item >= pokemons.count / 3 && self.nextURL != "NO" && isFree
    }
    
    func visibleIndexPathToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
            let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
            return Array(indexPathsIntersection)
    }
}

extension ViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            fetchPokemons()
        }
    }
}
