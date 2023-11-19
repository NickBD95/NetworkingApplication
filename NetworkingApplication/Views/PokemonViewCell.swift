//
//  PokemonViewCell.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//

import UIKit

class PokemonViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    func configure(pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        
//        NetworkingManager.shared.fetch( url: pokemon.url) { [unowned self] character in
//            
//            let imageUrl = character.sprites.other.home.front_default
//            
//            NetworkingManager.shared.fetchImage(fom: imageUrl) { data in
//                self.pokemonImageView.image = UIImage(data: data)
            }
        }
//    }
//}


