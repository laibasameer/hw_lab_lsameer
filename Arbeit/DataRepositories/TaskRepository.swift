
import Foundation
import Observation
import FirebaseFirestore

// Handles all Firestore operations for task records.
@Observable
class TaskRepository {

    @ObservationIgnored private let path: String = "tasks"
    @ObservationIgnored private let store = Firestore.firestore()
    @ObservationIgnored private var listener: ListenerRegistration?

    var tasks: [TaskItem] = []

    // Starts listening for task changes when the repository is created.
    init() {
        self.get()
    }

    // Removes the Firestore listener when the repository is released.
    deinit {
        listener?.remove()
    }

    // Reads tasks and keeps the local list synchronized with Firestore.
    func get() {
        listener = store.collection(path)
            .addSnapshotListener { [weak self] querySnapshot, error in

                guard let self = self else { return }

                if let error = error {
                    print("Error getting tasks: \(error.localizedDescription)")
                    return
                }

                self.tasks = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: TaskItem.self)
                } ?? []
            }
    }

    // Adds a new task to the Firestore collection.
    func create(_ task: TaskItem) {
        do {
            _ = try store.collection(path).addDocument(from: task)
        } catch {
            print("Error creating task: \(error.localizedDescription)")
        }
    }

    // Saves changes to an existing task document.
    func update(_ task: TaskItem) {
        guard let taskId = task.id else {
            print("Error updating task: Task ID is missing")
            return
        }

        do {
            try store.collection(path)
                .document(taskId)
                .setData(from: task)
        } catch {
            print("Error updating task: \(error.localizedDescription)")
        }
    }

    // Deletes a task from Firestore.
    func delete(_ task: TaskItem) {
        guard let taskId = task.id else {
            print("Error deleting task: Task ID is missing")
            return
        }

        store.collection(path).document(taskId).delete { error in
            if let error = error {
                print("Error deleting task: \(error.localizedDescription)")
            }
        }
    }
}


