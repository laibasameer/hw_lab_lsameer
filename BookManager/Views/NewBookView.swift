import SwiftUI

struct NewBookView: View {
    
    @EnvironmentObject var library: Library
    
    @State private var title = ""
    @State private var author = ""
    @State private var gender = "Male"
    @State private var displayed = true
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                
                TextField("Author", text: $author)
                
                Picker("Gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                }
                
                Toggle("Display", isOn: $displayed)
                
                Button("Add Book") {
                    let book = Book(
                        title: title,
                        author: author,
                        gender: gender,
                        displayed: displayed
                    )
                    
                    library.addBookToLibrary(book)
                }
            }
            .navigationTitle("New Book")
        }
    }
}

#Preview {
    NewBookView()
        .environmentObject(Library())
}
