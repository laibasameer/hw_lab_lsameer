
import SwiftUI

struct infoView: View {
    var body: some View {
        VStack {
            Text("TempConverter")
                .font(.largeTitle)
            
            Text("This app converts temperatures between Celsius and Fahrenheit.")
                .multilineTextAlignment(.center)
                .padding()
        }
        .navigationTitle("Info")
    }
}

#Preview {
    infoView()
}
//
//  infoView.swift
//  TempConverterApp
//
//  Created by Apple on 07/09/2026.
//
