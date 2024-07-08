//
//  DataController.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 30/06/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FavoriteGame")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load Core Data stack: \(error.localizedDescription)")
                fatalError("Failed to load Core Data stack: \(error.localizedDescription)")
            } else {
                print("Core Data stack loaded successfully")
            }
        }
    }

    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Context saved successfully")
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
            fatalError("Failed to save context: \(error.localizedDescription)")
        }
    }

    func addFavoriteGame(id: Int, name: String, released: String, rating: Double, backgroundImage: String?, description: String?, descriptionText: String?, context: NSManagedObjectContext) {
        // Check if the game with the same ID already exists
        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            if let existingGame = try context.fetch(fetchRequest).first {
                // Update the existing game
                editFavoriteGame(favoriteGame: existingGame, name: name, released: released, rating: rating, backgroundImage: backgroundImage, description: description, descriptionText: descriptionText, context: context)
            } else {
                // Create a new favorite game
                let favoriteGame = FavoriteGame(context: context)
                favoriteGame.id = Int16(id)
                favoriteGame.name = name
                favoriteGame.released = released
                favoriteGame.rating = rating
                favoriteGame.backgroundImage = backgroundImage
                favoriteGame.descriptionText = descriptionText

                save(context: context)
            }
        } catch {
            print("Failed to fetch favorite game: \(error.localizedDescription)")
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

    func removeFavoriteGame(id: Int, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            if let gameToDelete = try context.fetch(fetchRequest).first {
                context.delete(gameToDelete)
                save(context: context)
            }
        } catch {
            print("Failed to fetch favorite game to delete: \(error.localizedDescription)")
        }
    }
}





