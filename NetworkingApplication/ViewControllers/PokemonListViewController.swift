//
//  PokemonListViewController.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//

import UIKit
import Alamofire

final class PokemonListViewController: UITableViewController {
    
    private var pokemons: [Pokemon] = [] // пустой массив,мы будем его заполнять после того, как достанем массив [Pokemon], захватив в функции fetchPokemons
    private let networkingManager = NetworkingManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemons()
    }
    // создаем функциию вызова метода fetchPokemons и вызываем ее во вьюдидлоад
    private func fetchPokemons() {
        NetworkingManager.shared.fetchPokemons(from: List.url.rawValue) { [unowned self] result in
            
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons  // присваиваем наш полученный массив [Pokemon] пустому массиву, который создали выше
                self.tableView.reloadData() // обновляем данные таблицы, после парсинга
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
            guard let cell = cell as? PokemonViewCell else { return UITableViewCell() }
            
            let pokemon = pokemons[indexPath.row]
            cell.configure(pokemon: pokemon) 
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    

