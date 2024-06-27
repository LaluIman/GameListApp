//
//  SearchView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 27/06/24.
//

import SwiftUI

struct SearchView: View {
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
                       Text("Search Game")
                           .frame(maxHeight: .infinity)
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
               .navigationTitle("Search Game")
           }
           .environment(\.colorScheme, .dark)
       }
   }


#Preview {
    SearchView()
}
