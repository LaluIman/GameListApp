//
//  DetailView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import SwiftUI

struct DetailView: View {
    let game: Game
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var dataController = DataController()
    @State private var isFavorite = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    if let imageUrl = game.backgroundImage, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .frame(height: 300)
                            } else if phase.error != nil {
                                Color.red
                                    .frame(height: 300)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            } else {
                                ProgressView()
                                    .frame(height: 300)
                            }
                        }
                    } else {
                        Color.gray
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Text(game.name)
                        .font(.largeTitle).bold()
                        .foregroundStyle(.yellow)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack {
                        Text("Released: \(game.released)")
                            .font(.headline)
                            .padding(.bottom)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        HStack {
                            Text("Rating: \(game.rating, specifier: "%.1f")")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                        .padding(.bottom)
                        
                        Button(action: {
                            if isFavorite {
                                removeFromFavorites()
                            } else {
                                addToFavorites()
                            }
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundColor(.yellow)
                                .padding()
                        }
                        .disabled(isFavorite)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Game Detail")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.yellow)
                        
                        Text(game.description ?? "No description available.")
                            .font(.body)
                            .padding()
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
            }
            .listStyle(.plain)
            .padding()
            .background(Color(.systemBackground))
            .navigationTitle(game.name)
            .environment(\.colorScheme, .dark)
            .onAppear {
                checkIfFavorite()
            }
        }
    }
    
    private func addToFavorites() {
        dataController.addFavoriteGame(
            id: game.id,
            name: game.name,
            released: game.released,
            rating: game.rating,
            backgroundImage: game.backgroundImage,
            description: game.description,
            descriptionText: game.description,
            context: viewContext
        )
        isFavorite = true
    }
    
    private func removeFromFavorites() {
        dataController.removeFavoriteGame(id: game.id, context: viewContext)
        isFavorite = false
    }
    
    private func checkIfFavorite() {
        let favoriteGames = dataController.fetchFavoriteGames()
        if favoriteGames.contains(where: { $0.id == Int16(game.id) }) {
            isFavorite = true
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(game: Game(id: 1, name: "Sample Game", released: "2022-01-01", rating: 4.5, backgroundImage: "https://example.com/image.jpg", description: "This is a sample game description."))
    }
}





