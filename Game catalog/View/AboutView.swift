//
//  AboutView.swift
//  Game catalog
//
//  Created by Lalu Iman Abdullah on 26/06/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("ppcool") // Replace with your image name
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(.bottom, 20)
                
                Text("Lalu Iman Abdullah")
                    .font(.largeTitle).bold()
                    .padding()
                    .foregroundColor(.primary)
                
                Text("iOS developer")
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AboutView()
}

