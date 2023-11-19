//
//  NetworkingManager.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//


import Foundation
import Alamofire

//enum NetworkError: Error {
//    case invalidUrl
//    case noData
//    case decodingError
//}

enum List: String {
    case url = "https://pokeapi.co/api/v2/pokemon"

}

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetchPokemons(from url: String, completion: @escaping(Result<[Pokemon], AFError>) -> Void) {
        guard let url = URL(string: url) else { return }
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let pokemons = PokemonApp.getPokemons(from: value)
//                    print(value)
                    completion(.success(pokemons))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }


    func fetchImage(fom url: String, completion: @escaping(Data) -> Void ) {
        guard let url = URL(string: url) else {return}
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}

