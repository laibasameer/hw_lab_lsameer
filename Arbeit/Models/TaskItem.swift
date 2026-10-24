
import Foundation
import FirebaseFirestore

// Represents a task stored in Firestore.
struct TaskItem: Identifiable, Comparable, Codable, Hashable {

    // MARK: - Fields

    @DocumentID var id: String?
    var name: String
    var assignedTo: String
    var dueDate: Date
    var dateAdded: Date
    var completed: Bool

    // Specifies the fields used for Firestore encoding and decoding.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case assignedTo
        case dueDate
        case dateAdded
        case completed
    }

    // Compares tasks by name, assignee, and due date.
    static func == (lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.name == rhs.name &&
            lhs.assignedTo == rhs.assignedTo &&
            lhs.dueDate == rhs.dueDate
    }

    // Sorts tasks alphabetically by name.
    static func < (lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.name < rhs.name
    }
}

// MARK: - Validation

extension TaskItem {

    // Checks that a task has both a name and an assignee.
    static func isValid(name: String, assignedTo: String) -> Bool {
        return !name.isEmpty && !assignedTo.isEmpty
    }
}

