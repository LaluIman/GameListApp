//
//  ContentView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 27/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
        
        var body: some View {
            TabView(selection: $selectedTab) {
               HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
                .toolbarBackground(
                        Color.black,
                        for: .tabBar)
                
                FavoriteView()
                    .tabItem {
                        Label("Favorite", systemImage: "heart")
                    }
                    .tag(1)
                    .toolbarBackground(
                            Color.black,
                            for: .tabBar)
                    
        
                AboutView()
                    .tabItem {
                        Label("Author", systemImage: "person.circle")
                    }
                    .tag(2)
                
            }
            .onAppear {
                UITabBar.appearance().unselectedItemTintColor = .white
            }
            .accentColor(.yellow)
        }
    }


#Preview {
    ContentView()
}
