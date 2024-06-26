//
//  DetailView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import SwiftUI

struct DetailView: View {
    let game: Game
    
    var body: some View {
        
        List{
        VStack {
            if let imageUrl = game.backgroundImage, let url = URL(string: imageUrl) {
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
            
            Text(game.name)
                .font(.largeTitle).bold()
                .foregroundStyle(.yellow)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding()
            
            
                
            HStack {
                Text("Released:  \(game.released)")
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
            }
            
            
            VStack {
                Text("Game detail")
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
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(game: Game(id: 1, name: "Sample Game", released: "2022-01-01", rating: 4.5, backgroundImage: "https://example.com/image.jpg", description: "This is a sample game description."))
    }
}