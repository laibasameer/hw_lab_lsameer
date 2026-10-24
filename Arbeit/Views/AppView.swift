
import SwiftUI

// Owns the shared view model and displays the app's tabs.
struct AppView: View {
    @State private var tasksViewModel = TasksViewModel()

    // Builds the main task and new-task tabs.
    var body: some View {
        TabView {
            NavigationStack {
                TasksView()
            }
            .tabItem {
                Image(systemName: "checkmark.rectangle.stack.fill")
                Text("Tasks")
            }

            NavigationStack {
                NewTaskView()
            }
            .tabItem {
                Image(systemName: "plus.app.fill")
                Text("New Task")
            }
        }
        .environment(tasksViewModel)
    }
}


