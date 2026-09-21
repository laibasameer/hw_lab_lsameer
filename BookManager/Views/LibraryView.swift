//
import SwiftUI

struct LibraryView: View {
    
    @EnvironmentObject var library: Library
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(library.books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        BookRowView(book: book)
                    }
                }
                .onDelete(perform: library.removeRows)
            }
            .navigationTitle("Library")
        }
    }
}

#Preview {
    LibraryView()
        .environmentObject(Library())
}
//  LibraryView.swift
//  BookManager
//
//  Created by Apple on 20/09/2026.
//

