
import SwiftUI

// Displays and edits an existing task.
struct TaskDetailsView: View {
    let task: TaskItem

    @Environment(TasksViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    @State private var name: String
    @State private var assignedTo: String
    @State private var dueDate: Date
    @State private var completed: Bool
    @State private var showingAlert = false
    @State private var showingDeleteConfirmation = false

    // Initializes editable state using the selected task's values.
    init(task: TaskItem) {
        self.task = task
        _name = State(initialValue: task.name)
        _assignedTo = State(initialValue: task.assignedTo)
        _dueDate = State(initialValue: task.dueDate)
        _completed = State(initialValue: task.completed)
    }

    // Builds the editable task form and delete confirmation.
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $name)
                TextField("Assigned To", text: $assignedTo)

                DatePicker(
                    "Due Date",
                    selection: $dueDate,
                    displayedComponents: .date
                )

                Toggle("Completed", isOn: $completed)
            }

            Section(header: Text("Metadata")) {
                HStack {
                    Text("Date Added")
                    Spacer()

                    Text(task.dateAdded, style: .date)
                        .foregroundColor(.secondary)
                }
            }

            Section {
                Button("Delete Task", role: .destructive) {
                    showingDeleteConfirmation = true
                }
            }
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveTask()
                }
            }
        }
        .alert("Validation Error", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter both name and assignee")
        }
        .confirmationDialog(
            "Delete Task",
            isPresented: $showingDeleteConfirmation
        ) {
            Button("Delete", role: .destructive) {
                viewModel.destroy(task)
                dismiss()
            }

            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this task?")
        }
    }

    // Validates the edited fields, updates the task, and closes the screen.
    private func saveTask() {
        guard TaskItem.isValid(name: name, assignedTo: assignedTo) else {
            showingAlert = true
            return
        }

        var updated = task
        updated.name = name
        updated.assignedTo = assignedTo
        updated.dueDate = dueDate
        updated.completed = completed

        viewModel.update(updated)
        dismiss()
    }
}
