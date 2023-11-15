//
//  PokemonListViewController.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//

import UIKit

class PokemonListViewController: UITableViewController {
    
    var pokemons: [Pokemon] = [] // пустой массив, который будет принимать инфу после парсинга.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemons()
    }
    
    private func fetchPokemons() {
        NetworkingManager.shared.fetch(dataType: PokemonApp.self, url: List.url.rawValue) { [unowned self] pokemonApp in
            self.pokemons = pokemonApp.results // присваиваем нашему пустому массиву захваченный массив из блока замыкания.
            self.tableView.reloadData()
        }
    }
}

extension PokemonListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonViewCell else { return UITableViewCell() }
        let pokemon = pokemons[indexPath.row]
       
        cell.configure(pokemon: pokemon)
        cell.selectionStyle = .none
        return cell
    }
}


