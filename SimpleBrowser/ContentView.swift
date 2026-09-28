//
//  ContentView.swift
//  SimpleBrowser
//
//  Created by Apple on 27/09/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(viewModel: viewModel)
            Divider()
            WebView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Divider()
            BottomBar(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.shouldShowShareSheet) {
            ShareSheet(activityItems: [viewModel.urlString])
        }
    }
}

#Preview {
    ContentView()
}
