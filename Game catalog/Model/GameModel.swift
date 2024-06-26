//
//  GameModel.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import Foundation

struct Game: Identifiable, Codable {
    let id: Int
    let name: String
    let released: String
    let rating: Double
    let backgroundImage: String?
    var description: String? // tambahkan properti description
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case rating
        case backgroundImage = "background_image"
        case description
    }
}

struct GameResponse: Codable {
    let results: [Game]
}


