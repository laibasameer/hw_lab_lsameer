
import Foundation
import Observation

// Provides task operations to SwiftUI views.
@Observable
class TasksViewModel {

    @ObservationIgnored private let repository: TaskRepository

    // Creates a view model using the supplied repository or a new one.
    init(repository: TaskRepository = TaskRepository()) {
        self.repository = repository
    }

    // Exposes the tasks maintained by the repository.
    var tasks: [TaskItem] {
        repository.tasks
    }

    // Requests that the repository create a task.
    func add(_ task: TaskItem) {
        repository.create(task)
    }

    // Requests that the repository update a task.
    func update(_ task: TaskItem) {
        repository.update(task)
    }

    // Requests that the repository delete a task.
    func destroy(_ task: TaskItem) {
        repository.delete(task)
    }
}

