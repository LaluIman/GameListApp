//
//  GameRow.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import SwiftUI

struct GameRow: View {
    let game: Game
    
    var body: some View {
        HStack {
            if let imageUrl = game.backgroundImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 100)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 110, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .clipped()
                        case .failure:
                            Image(systemName: "photo")
                            .frame(width: 110, height: 125)
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        @unknown default:
                            ProgressView()
                                .frame(width: 100, height: 100)
                    }
                }
            } else {
                Color.gray.frame(width: 100, height: 100)
            }
            
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.title3).bold()
                    .foregroundColor(.yellow)
                Text("Released: \(game.released)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack {
                    Text("\(game.rating, specifier: "%.1f")")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.yellow)
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
        }
    }
}


struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game(id: 1, name: "Sample Game", released: "2022-01-01", rating: 4.5, backgroundImage: "https://example.com/image.jpg", description: "This is a sample game description.")
        return GameRow(game: game)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
