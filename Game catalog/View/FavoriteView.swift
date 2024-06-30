//
//  FavoriteView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 30/06/24.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @FetchRequest(
        entity: FavoriteGame.entity(),
        sortDescriptors: []
    ) var favoriteGames: FetchedResults<FavoriteGame>
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView{
            List {
                ForEach(favoriteGames) { game in
                    NavigationLink(destination: DetailView(game: Game(
                        id: game.id!.uuidString.hashValue,
                        name: game.name ?? "",
                        released: game.released ?? "",
                        rating: game.rating,
                        backgroundImage: game.backgroundImage
                    ))) {
                        VStack(alignment: .leading) {
                            HStack{
                                if let imageUrl = game.backgroundImage, let url = URL(string: imageUrl) {
                                    AsyncImage(url: url) { phase in
                                        if let image = phase.image {
                                            image.resizable()
                                                .scaledToFill()
                                                .frame(width: 70,height: 70)
                                                .clipped()
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        } else if phase.error != nil {
                                            Color.red.frame(height: 50)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        } else {
                                            ProgressView()
                                                .frame(height: 50)
                                        }
                                    }
                                } else {
                                    Color.clear.frame(height: 50)
                                }
                                VStack(alignment: .leading){
                                    Text(game.name ?? "")
                                        .foregroundStyle(.yellow)
                                        .font(.title3).bold()
                                    Text("Released: \(game.released ?? "")")
                                        .font(.subheadline)
                                    Text("Rating: \(game.rating, specifier: "%.1f")")
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteFavoriteGame)
            }
            .navigationTitle("Favorite Games")
        }
        .environment(\.colorScheme, .dark)
    }

    private func deleteFavoriteGame(offsets: IndexSet) {
        withAnimation {
            offsets.map { favoriteGames[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("Failed to delete game: \(error.localizedDescription)")
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environment(\.managedObjectContext, DataController(inMemory: true).container.viewContext)
    }
}





