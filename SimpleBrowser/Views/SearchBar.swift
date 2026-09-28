//
//  SearchBar.swift
//  SimpleBrowser
//
//  Created by Apple on 27/09/2026.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            TextField("Enter URL", text: $viewModel.urlString)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.URL)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal)
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
                Image(systemName: "arrow.clockwise")
            }
            .padding(.trailing)
        }
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
    }
}

#Preview {
    SearchBar(viewModel: ViewModel())
}
