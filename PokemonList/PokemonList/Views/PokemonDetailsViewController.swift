//
//  PokemonDetailsViewController.swift
//  PokemonList
//
//  Created by Eda Barutçu on 22.03.2023.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    var pokemonDetails : PokemonDetailsData?
    let sections : [String] = PokemonDetailsService.getSections()
    let image = UIImageView()
    let name = UILabel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.view.backgroundColor = .white
        setupImageWithLabel()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        if let name = pokemonDetails?.name {
            self.title = name + " Details"
        } else {
            self.title = "Pokemon details"
        }
    }
    
    private func setupImageWithLabel() {
        image.load(url: URL(string: pokemonDetails!.sprites!.frontDefault!)!)
        image.frame = CGRect(x: view.bounds.midX / 2, y: 100, width: 200, height: 200)
        view.addSubview(image)
        name.frame = CGRect(x: 20, y: image.frame.height + 100, width: UIScreen.main.bounds.width - 40, height: 50)
        name.font = .systemFont(ofSize: 24, weight: .bold)
        name.textAlignment = .center
        name.textColor = .black
        name.text = pokemonDetails!.name
        view.addSubview(name)
    }
    
    private func setupTableView() {
        tableView.frame = CGRect(x: 5, y: 350, width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height - 300)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.register(PokemonDetailsSingleLabelTableViewCell.self, forCellReuseIdentifier: "PokemonDetailsSingleLabelCell")
        tableView.register(PokemonDetailsStatTableViewCell.self, forCellReuseIdentifier: "PokemonDetailsStatsCell")
        view.addSubview(tableView)
    }
}

extension PokemonDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            if let pokemonIndex = pokemonDetails?.gameIndices {
                return pokemonIndex.count
            } else {
                return 0
            }
        case 4:
            if let pokemonStats = pokemonDetails?.stats {
                return pokemonStats.count
            } else {
                return 0
            }
        case 5:
            if let pokemonTypes = pokemonDetails?.types {
                return pokemonTypes.count
            } else {
                return 0
            }
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let abilities = pokemonDetails?.abilities{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailsSingleLabelCell") as? PokemonDetailsSingleLabelTableViewCell {
                    cell.setup(with: abilities)
                    return cell
                }}
        case 1:
            if let baseExp = pokemonDetails?.baseExperience {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailsSingleLabelCell") as? PokemonDetailsSingleLabelTableViewCell {
                    cell.setup(exp: baseExp)
                    return cell
                }
            }
        case 2:
            if let specie = pokemonDetails?.species {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailsSingleLabelCell") as? PokemonDetailsSingleLabelTableViewCell {
                    cell.setup(specie: specie)
                    return cell
                }
            }
        case 3:
            if let gameIndices = pokemonDetails?.gameIndices {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailsSingleLabelCell") as? PokemonDetailsSingleLabelTableViewCell {
                    cell.setup(specie: gameIndices[indexPath.row].version)
                    return cell
                }
            }
        case 4:
            if let gameStats = pokemonDetails?.stats {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailsStatsCell") as? PokemonDetailsStatTableViewCell {
                    
                    cell.setup(statistic: gameStats[indexPath.row])
                    
                    return cell
                }
            }
        case 5:
            if let typologies = pokemonDetails?.types {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonDetailsSingleLabelCell") as? PokemonDetailsSingleLabelTableViewCell {
                    cell.setup(specie: typologies[indexPath.row].type)
                    return cell
                }
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

