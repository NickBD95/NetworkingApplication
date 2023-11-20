//
//  NetworkingManager.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//


import Foundation
import Alamofire

enum List: String {
    case url = "https://pokeapi.co/api/v2/pokemon"
}

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    // метод для того, чтобы сформировать массив из Pokemon и заполнить таблицу его данными
    func fetchPokemons(from url: String, completion: @escaping(Result<[Pokemon], AFError>) -> Void) {
        guard let url = URL(string: url) else { return }
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let pokemons = PokemonApp.getPokemons(from: value)
                    completion(.success(pokemons))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    // метод, чтобы достать экземпляр Character
    func fetchCharachers(from url: String, completion: @escaping(Result<Character, AFError>) -> Void) {
        guard let url = URL(string: url) else { return }
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let character = Character.getCharacter(from: value)
                    completion(.success(character ?? Character(characterDict: [:])))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    // метод для того, чтобы вытащить картинку из Character
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        guard let url = URL(string: url) else { return }
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    print(imageData)
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

