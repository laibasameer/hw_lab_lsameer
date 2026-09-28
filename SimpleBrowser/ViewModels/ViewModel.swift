// ViewModel.swift
// SimpleBrowser
//
// Created by Apple on 27/09/2026.

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    
    @Published var urlString: String = "https://apple.com"
    @Published var shouldShowShareSheet: Bool = false
    // Add other properties and logic as needed for your browser.
}

