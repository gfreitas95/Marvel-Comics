//
//  HomeViewModel.swift
//  MarvelComics
//
//  Created by Gustavo Freitas on 28/03/22.
//

import UIKit
import CryptoKit

class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map({String(format: "%02hhx", $0)}).joined()
    }
    
    func fetchCharacterDataWith(name: String, completion: @escaping (Result<CharacterResult, Error>) -> ()) {
        
        let publicKey = Constants.PUBLIC_KEY
        let privateKey = Constants.PRIVATE_KEY
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(name)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10.0
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if error != nil {
                print("\n func fetchCharacterDataWith() -> \(String(describing: error))")
            }

            guard let data = data else { return }
                
            do {
                let response = try JSONDecoder().decode(CharacterResult.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
