//
//  DataController.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 30/06/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FavoriteGame")

    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error.localizedDescription)")
            }
        }
    }

    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            fatalError("Failed to save context: \(error.localizedDescription)")
        }
    }

    func addFavoriteGame(id: UUID, name: String, released: String, rating: Double, backgroundImage: String?, description: String?, context: NSManagedObjectContext) {
        let favoriteGame = FavoriteGame(context: context)
        favoriteGame.id = id
        favoriteGame.name = name
        favoriteGame.released = released
        favoriteGame.rating = rating
        favoriteGame.backgroundImage = backgroundImage

        save(context: context)
    }
    
    func editFavoriteGame(favoriteGame: FavoriteGame, name: String, released: String, rating: Double, backgroundImage: String?, context: NSManagedObjectContext) {
        favoriteGame.name = name
        favoriteGame.released = released
        favoriteGame.rating = rating
        favoriteGame.backgroundImage = backgroundImage

        save(context: context)
    }
}
