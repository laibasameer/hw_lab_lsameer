//
//  BottomBar.swift
//  SimpleBrowser
//
//  Created by Apple on 27/09/2026.
//

import SwiftUI

struct BottomBar: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                // Go back logic placeholder
            }) {
                Image(systemName: "chevron.left")
            }
            .disabled(true) // Add back logic if you track history
            Spacer()
            Button(action: {
                viewModel.shouldShowShareSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

#Preview {
    BottomBar(viewModel: ViewModel())
}
