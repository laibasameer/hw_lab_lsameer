//
//  WebView.swift
//  SimpleBrowser
//
//  Created by Apple on 27/09/2026.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: ViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: viewModel.urlString), uiView.url != url {
            let req = URLRequest(url: url)
            uiView.load(req)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        // Optional: handle navigation events here.
    }
}

#Preview {
    WebView(viewModel: ViewModel())
}
