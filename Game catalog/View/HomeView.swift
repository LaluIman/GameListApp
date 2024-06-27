//
//  HomeView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = GamesViewModel()
    @State private var topGames: [Game] = []

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.games.isEmpty {
                    ProgressView()
                        .padding()
                        .frame(maxHeight: .infinity)
                } else {
                    List {
                        // Carousel Section
                        VStack(alignment: .leading){
                            Text("Top 5 games")
                                .font(.title3).bold()
                                .foregroundStyle(.yellow)
                                .padding()
                            Section {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 10) {
                                        ForEach(topGames, id: \.id) { game in
                                            GameCard(game: game)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                        
                        // Games List Section
                        VStack(alignment: .leading){
                            Text("Games by rank")
                                .font(.title3).bold()
                                .foregroundStyle(.yellow)
                                .padding()
                            Section {
                                ForEach(viewModel.games.indices, id: \.self) { index in
                                    let game = viewModel.games[index]
                                    HStack {
                                        Text("\(index + 1)")
                                            .foregroundStyle(.yellow)
                                            .padding(5)
                                        NavigationLink(destination: DetailView(game: game)) {
                                            GameRow(game: game)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .onAppear {
                        if viewModel.games.count >= 5 {
                            topGames = Array(viewModel.games.prefix(5))
                        } else {
                            topGames = viewModel.games
                        }
                    }
                }
            }
            .progressViewStyle(.circular)
            .background(Color(.systemBackground))
            .navigationTitle("Games Catalog")
        }
        .environment(\.colorScheme, .dark)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



