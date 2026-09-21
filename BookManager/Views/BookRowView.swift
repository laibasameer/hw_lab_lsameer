import SwiftUI

struct BookRowView: View {
    
    var book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.headline)
            
            Text(book.author)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    BookRowView(
        book: Book(
            title: "Pride and Prejudice",
            author: "Jane Austen",
            gender: "Female"
        )
    )
}
//  BookRowView.swift
//  BookManager
//
//  Created by Apple on 20/09/2026.
//

