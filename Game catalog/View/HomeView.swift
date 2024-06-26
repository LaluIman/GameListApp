//
//  HomeView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject var viewModel = GamesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search game", text: $viewModel.searchQuery)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                if viewModel.games.isEmpty {
                    ProgressView()
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.games) { game in
                        NavigationLink(destination: DetailView(game: game)) {
                            GameRow(game: game)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .progressViewStyle(.circular)
            .background(Color(.systemBackground))
            .navigationTitle("Games by rank")
        }
        .environment(\.colorScheme, .dark)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



