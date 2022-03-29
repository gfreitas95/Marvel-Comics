//
//  Character.swift
//  MarvelComics
//
//  Created by Gustavo Freitas on 28/03/22.
//

import UIKit

struct CharacterResult: Codable {
    var data: CharacterData
}

struct CharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String: String]
    var urls: [[String: String]]
}
