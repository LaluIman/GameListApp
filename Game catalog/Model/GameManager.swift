//
//  GameNetwork.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import Foundation

protocol GamesManagerDelegate: AnyObject {
    func didUpdateGames(gamesManager: GamesManager, gamesModel: [Game])
}

struct GamesManager {
    weak var delegate: GamesManagerDelegate?
    
    func fetchGame() {
        let gameURL = "https://api.rawg.io/api/games?key=7ecfcb8fa13a47e190e790f26c8e7e87"
        performQuery(gameURL, responseType: GameResponse.self)
    }
    
    func searchGame(searchName: String) {
        let gameSearchURL = "https://api.rawg.io/api/games?key=7ecfcb8fa13a47e190e790f26c8e7e87&search=\(searchName)&ordering=-rating"
        performQuery(gameSearchURL, responseType: GameResponse.self)
    }
    
    private func performQuery<T: Codable>(_ urlString: String, responseType: T.Type) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let safeData = data, error == nil else {
                print("Failed to get data from URLSession data task")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(responseType, from: safeData)
                
                if let gameResponse = decodedData as? GameResponse {
                    var gamesWithDescription: [Game] = []
                    for var game in gameResponse.results {
                        // Fetch additional details including description
                        if let gameDetailURL = URL(string: "https://api.rawg.io/api/games/\(game.id)?key=7ecfcb8fa13a47e190e790f26c8e7e87") {
                            let detailData = try Data(contentsOf: gameDetailURL)
                            let detailResponse = try decoder.decode(Game.self, from: detailData)
                            game.description = detailResponse.description
                        }
                        gamesWithDescription.append(game)
                    }
                    
                    self.delegate?.didUpdateGames(gamesManager: self, gamesModel: gamesWithDescription)
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        task.resume()
    }
}




