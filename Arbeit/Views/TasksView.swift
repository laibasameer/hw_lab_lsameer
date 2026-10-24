
import SwiftUI

// Displays the task list and handles navigation to task details.
struct TasksView: View {
    @Environment(TasksViewModel.self) private var viewModel
    @State private var showingNewTask = false

    // Builds the task list, toolbar, and navigation destinations.
    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                NavigationLink(value: task) {
                    TaskRowView(task: task)
                }
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle("Arbeit")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { showingNewTask = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingNewTask) {
            NewTaskView()
                .environment(viewModel)
        }
        .navigationDestination(for: TaskItem.self) { task in
            TaskDetailsView(task: task)
        }
    }

    // Deletes the selected tasks using their list positions.
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            viewModel.destroy(viewModel.tasks[index])
        }
    }
}
