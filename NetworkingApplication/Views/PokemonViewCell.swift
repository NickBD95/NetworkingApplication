//
//  PokemonViewCell.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//

import UIKit

final class PokemonViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    private let networkingManager = NetworkingManager.shared
    
    func configure(pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        // метод для того, чтобы вытащить экземпляр Character
        NetworkingManager.shared.fetchCharachers(from: pokemon.url) { result in
            switch result {
    
            case .success(let character):
                self.configureImage(character: character)
            case .failure(let error):
                print(error)
            }
        }
    }
    // создаем метод для того, чтобы вытащить картинку из json и присваиваем ее нашему аутлету, вызовем ее после того ,как вытащим экземпляр Character выше
    func configureImage(character: Character) {
        NetworkingManager.shared.fetchData(from: character.sprites.other.home.front_default) { result in
            switch result {
            case .success(let imageData):
                self.pokemonImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
    



