import SwiftUI

struct BookDetailView: View {
    
    var book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text(book.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Author: \(book.author)")
                .font(.title2)
            
            Text("Gender: \(book.gender)")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .navigationTitle("Book Details")
    }
}

#Preview {
    BookDetailView(
        book: Book(
            title: "Pride and Prejudice",
            author: "Jane Austen",
            gender: "Female"
        )
    )
}
