//
//  Pokemon.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//

import Foundation

struct PokemonApp: Codable {
    let results: [Pokemon]
    
    init(results: [Pokemon]) {
        self.results = results
    }
    
    
    static func getPokemons(from value: Any) -> [Pokemon] {
//        guard let pokemonsData = value as? [String:[[String: Any]]] else { return [] }
        guard let pokemonsData = value as? [[String: Any]] else { return [] }
        
        var pokemons = [Pokemon]()
        
//        for pokemonData in pokemonsData {
//            for item in pokemonData.value {
//               let pokemon = Pokemon(pokemonData: item)
//                pokemons.append(pokemon)
//            }
//        }
        
        for pokemonData in pokemonsData {
            let pokemon = Pokemon(pokemonData: pokemonData)
            pokemons.append(pokemon)
        }
        
        return pokemons
        
    }
    
}

struct Pokemon: Codable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init(pokemonData: [String: Any]){
        self.name = pokemonData["name"] as? String ?? ""
        self.url = pokemonData["url"] as? String ?? ""
        
        
    }
}

// след ссылка
struct Character: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let other: Home
}

struct Home: Codable {
    let home: Front
}

struct Front: Codable {
    let front_default: String
}


//  "sprites": {
//
//      "other": {
//
//              "home": {
//                          "front_default":                                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png",
//

