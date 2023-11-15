//
//  NetworkingManager.swift
//  NetworkingApplication
//
//  Created by Nikolai Grachev on 14.11.2023.
//


import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

enum List: String {
    case url = "https://pokeapi.co/api/v2/pokemon"
}

class NetworkingManager {
    static let shared = NetworkingManager()
    
//    func fetchPokemons(url: String, completion: @escaping([Pokemon]) -> Void ) {
//        // объявляем метод с двумя параметрами: url с типом string (как указано в модели по json файлу) и замыканием, которое захватывает ту часть модели, которую необходимо передать на экран, где будут испольоваться даные из него.
//        guard let url = URL(string: url) else { return } // Проверяем ссылку на валидность
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else { // Извлекаем опционал из data
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder() // создаем экзкемляр декодера
//                let pokemonApp = try decoder.decode(PokemonApp.self, from: data) 
//                // вызываем метод decode у этого экземпляра, чтобы сделать парсинг json
//                
//                DispatchQueue.main.async {
//                    completion(pokemonApp.results)
//                }
//                
//                // захватываем ту часть json файла, которую нужно передать на экран, где эта инфа будет использоваться
//            } catch {
//                print(error)
//            }
//        }.resume() // метод, который запускает загрузку из сети.
//    }
    
    func fetch<T: Decodable>(dataType: T.Type, url: String, completion: @escaping(T) -> Void ) {
        // объявляем метод с двумя параметрами: url с типом string (как указано в модели по json файлу) и замыканием, которое захватывает ту часть модели, которую необходимо передать на экран, где будут испольоваться даные из него.
        guard let url = URL(string: url) else { return } // Проверяем ссылку на валидность
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { // Извлекаем опционал из data
                return
            }
            
            do {
                let decoder = JSONDecoder() // создаем экзкемляр декодера
                let type = try decoder.decode(T.self, from: data)
                // вызываем метод decode у этого экземпляра, чтобы сделать парсинг json
                
                DispatchQueue.main.async {
                    completion(type)
                }
                
                // захватываем ту часть json файла, которую нужно передать на экран, где эта инфа будет использоваться
            } catch {
                print(error)
            }
        }.resume() // метод, который запускает загрузку из сети.
    }
    
    func fetchImage(fom url: String, completion: @escaping(Data) -> Void ) {
        guard let url = URL(string: url) else {return}
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {return} // метод помогает получить картинку по url адресу, при загрузке выходим из основного потока
            
            DispatchQueue.main.async { // заходим в основной потом при непосредственном присваивании картинок нашему UiImageView
                completion(imageData)
            }
        }
    }

    private init() {}
}

