//
//  GameCard.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 27/06/24.
//

import SwiftUI

struct GameCard: View {
    let game: Game

    var body: some View {
        ZStack(alignment: .bottomLeading){
            if let imageUrl = game.backgroundImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 150)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.horizontal, 10)
                    case .failure:
                      Image(systemName: "photo")
                            .frame(width: 300, height: 150)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal, 10)
                    case .empty:
                        ProgressView()
                            .frame(width: 300, height: 150)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.horizontal, 10)
                    @unknown default:
                        EmptyView()
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.horizontal, 10)
                    }
                }
            } else {
                ZStack {
                    Image(systemName: "photo")
                          .frame(width: 300, height: 150)
                          .background(Color(.secondarySystemBackground))
                          .cornerRadius(10)
                          .padding(.horizontal, 10)
                       Text("Cannot load")
                           .foregroundColor(.white)
                           .font(.headline)
                   }
            }
            Text(game.name)
                   .font(.headline)
                   .foregroundColor(.yellow)
                   .padding(.horizontal, 10)
                   .padding(.vertical, 5)
                   .background(LinearGradient(colors: [Color.black.opacity(0.2), Color.gray], startPoint: .bottomLeading, endPoint: .topTrailing))
                   .clipShape(RoundedRectangle(cornerRadius: 5))
                   .padding(.top, 10)
                   .padding(.leading, 10)
        }
    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game(id: 1, name: "Sample Game", released: "2023-01-01", rating: 4.5, backgroundImage: "https://example.com/sample.jpg", description: "A sample game for preview purposes.")
        return GameCard(game: game)
            .previewLayout(.fixed(width: 250, height: 250)) // Adjust as necessary
            .padding()
    }
}
