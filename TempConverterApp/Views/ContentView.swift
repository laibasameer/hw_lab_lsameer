//
//  ContentView.swift
//  TempConverterApp
//
//  Created by Apple on 07/09/2026.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewController = ViewController()
    @State private var inputTemp = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.80)
                LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.gray]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.60)
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Text(viewController.convertedTempString)
                            .font(.system(size: 50))
                        
                        Text(viewController.isConvertingCtoF ? "ºF" : "ºC")
                            .font(.system(size: 30))
                    }
                    
                    Text("Enter Temperature:")
                        .font(.headline)
                    
                    HStack {
                        TextField("Temperature", text: $inputTemp)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                        
                        Text(viewController.isConvertingCtoF ? "ºC" : "ºF")
                    }
                    
                    Toggle(
                        "Convert C → F",
                        isOn: $viewController.isConvertingCtoF
                    )
                    .padding()
                    
                    Button("Convert") {
                        viewController.setInputTempString(inputTemp)
                        viewController.convert()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                    )
                    
                    Spacer()
                    NavigationLink(destination: infoView()) {
                        Text("Info")
                    }
                    .padding()
                }
            }
        }
    }
}
