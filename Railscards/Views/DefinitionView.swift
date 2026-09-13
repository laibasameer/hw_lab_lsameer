import SwiftUI

struct DefinitionView: View {
    let viewModel: CardViewModel
    
    var body: some View {
        ZStack {
            Text(viewModel.flashcard.definition)
                .padding()
                .multilineTextAlignment(.center)
        }
        .frame(width: 350, height: 200)
        .overlay(
            // adding gray outline to cards
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Color.gray)
        )
    }
}

#Preview {
    DefinitionView(viewModel: CardViewModel())
}
//  DefinitionView.swift
//  RailsCards
//
//  Created by Apple on 13/09/2026.
//


