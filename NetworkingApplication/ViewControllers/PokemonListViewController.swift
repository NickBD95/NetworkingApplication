//
//  PokemonListViewController.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//

import UIKit
import Alamofire

class PokemonListViewController: UITableViewController {
    
    var pokemons: [Pokemon] = [] // пустой массив, который будет принимать инфу после парсинга.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        fetchPokemons()
        
        tableView.reloadData()
        print(pokemons)
        
        for i in pokemons {
            print(i)
        }
    }
    
    private func fetchPokemons() {
        NetworkingManager.shared.fetchPokemons(from: List.url.rawValue) { [unowned self] result in
            
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons 
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension PokemonListViewController {
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            pokemons.count
            
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonViewCell else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
            guard let cell = cell as? PokemonViewCell else { return UITableViewCell() }
            let pokemon = pokemons[indexPath.row]
            
            cell.configure(pokemon: pokemon)
//            cell.selectionStyle = .none
            return cell
        }
    }
    
    

