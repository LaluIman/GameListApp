//
//  NetworkManager.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import Foundation
import Combine

class GamesViewModel: ObservableObject, GamesManagerDelegate {
    @Published var games: [Game] = []
    @Published var searchQuery: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var gamesManager = GamesManager()
    
    init() {
        gamesManager.delegate = self
        fetchGames()
        
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] query in
                self?.fetchGames(searchQuery: query)
            }
            .store(in: &cancellables)
    }
    
    func fetchGames(searchQuery: String = "") {
        if searchQuery.isEmpty {
            gamesManager.fetchGame()
        } else {
            gamesManager.searchGame(searchName: searchQuery)
        }
    }
    
    func didUpdateGames(gamesManager: GamesManager, gamesModel: [Game]) {
        DispatchQueue.main.async {
            self.games = gamesModel
        }
    }
}
