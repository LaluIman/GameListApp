//
//  SwiftUIView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import SwiftUI

struct TabssView: View {
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
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
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



struct TabssView_Previews: PreviewProvider {
    static var previews: some View {
        TabssView()
    }
}

