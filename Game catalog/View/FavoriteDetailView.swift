//
//  FavoriteDetailView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 01/07/24.
//

import SwiftUI

struct FavoriteDetailView: View {
    let favoriteGame: FavoriteGame
    
    var body: some View {
        VStack {
            // Display favorite game details
            ScrollView {
                VStack {
                    if let imageUrl = favoriteGame.backgroundImage, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .frame(height: 300)
                            } else if phase.error != nil {
                                Color.red.frame(height: 300)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            } else {
                                ProgressView()
                                    .frame(height: 300)
                            }
                        }
                    } else {
                        Color.gray.frame(height: 300)
                    }
                    
                    Text(favoriteGame.name ?? "")
                        .font(.largeTitle).bold()
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack {
                        Text("Released: \(favoriteGame.released ?? "")")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        HStack {
                            Text("Rating: \(favoriteGame.rating, specifier: "%.1f")")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.bottom)
                    
                    VStack {
                        Text("Game detail")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        Text(favoriteGame.descriptionText ?? "No description available.")
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
            .navigationTitle(favoriteGame.name ?? "")
            .environment(\.colorScheme, .dark)
        }
    }
}

struct FavoriteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController(inMemory: true).container.viewContext
        let sampleFavoriteGame = FavoriteGame(context: context)
        sampleFavoriteGame.name = "Sample Game"
        sampleFavoriteGame.released = "2023-01-01"
        sampleFavoriteGame.rating = 4.5
        sampleFavoriteGame.backgroundImage = "https://example.com/image.jpg"
        sampleFavoriteGame.descriptionText = "This is a sample game description."
        
        return FavoriteDetailView(favoriteGame: sampleFavoriteGame)
            .environment(\.managedObjectContext, context)
    }
}

