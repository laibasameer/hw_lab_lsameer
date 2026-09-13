//
//  ContentView.swift
//  RailsCards
//
//  Created by Apple on 13/09/2026.
//

import SwiftUI

struct CardView: View {
    @State private var viewModel = CardViewModel()
    
    var body: some View {
        NavigationStack {
            //makes the command clickable and gets to the definition
            ZStack {
                NavigationLink {
                    DefinitionView(viewModel: viewModel)
                } label: {
                    Text(viewModel.flashcard.command)
                }
            }
            .frame(width: 350, height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(Color.gray)
            )
            // new random card each time
            .onAppear {
                viewModel.drawNewCard()
            }
        }
    }
}

#Preview {
    CardView()
}
