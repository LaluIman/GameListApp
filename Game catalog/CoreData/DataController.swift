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

    func addFavoriteGame(id: UUID, name: String, released: String, rating: Double, backgroundImage: String?, description: String?, descriptionText: String?, context: NSManagedObjectContext) {
        // Check if the game with the same ID already exists
        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        if let existingGame = try? context.fetch(fetchRequest).first {
            // Update the existing game
            editFavoriteGame(favoriteGame: existingGame, name: name, released: released, rating: rating, backgroundImage: backgroundImage, description: description, descriptionText: descriptionText, context: context)
        } else {
            // Create a new favorite game
            let favoriteGame = FavoriteGame(context: context)
            favoriteGame.id = id
            favoriteGame.name = name
            favoriteGame.released = released
            favoriteGame.rating = rating
            favoriteGame.backgroundImage = backgroundImage
            favoriteGame.descriptionText = descriptionText

            save(context: context)
        }
    }
    
    func editFavoriteGame(favoriteGame: FavoriteGame, name: String, released: String, rating: Double, backgroundImage: String?, description: String?, descriptionText: String?, context: NSManagedObjectContext) {
        favoriteGame.name = name
        favoriteGame.released = released
        favoriteGame.rating = rating
        favoriteGame.backgroundImage = backgroundImage
        favoriteGame.descriptionText = descriptionText

        save(context: context)
    }
    
    func fetchFavoriteGames() -> [FavoriteGame] {
        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching favorite games: \(error)")
            return []
        }
    }
    
    
}

