import Testing
import Foundation
@testable import Arbeit

// Tests validation, equality, and sorting for TaskItem.
@MainActor
struct TaskItemTests {

    nonisolated static let fixedDate =
        Date(timeIntervalSince1970: 1_700_000_000)

    // Creates a sample task with consistent values for testing.
    private func sample(
        name: String = "Write lab",
        assignedTo: String = "Prof H",
        dueDate: Date = TaskItemTests.fixedDate
    ) -> TaskItem {
        TaskItem(
            name: name,
            assignedTo: assignedTo,
            dueDate: dueDate,
            dateAdded: TaskItemTests.fixedDate,
            completed: false
        )
    }

    // Checks that validation rejects a missing task name.
    @Test func validationRejectsEmptyName() {
        #expect(TaskItem.isValid(
            name: "",
            assignedTo: "someone"
        ) == false)
    }

    // Checks that validation rejects a missing assignee.
    @Test func validationRejectsEmptyAssignee() {
        #expect(TaskItem.isValid(
            name: "something",
            assignedTo: ""
        ) == false)
    }

    // Checks that validation accepts both required fields.
    @Test func validationAcceptsBothPresent() {
        #expect(TaskItem.isValid(
            name: "something",
            assignedTo: "someone"
        ) == true)
    }

    // Checks that equality ignores document ID and completion status.
    @Test func equalityIgnoresIdAndCompletion() {
        var a = sample()
        var b = sample()

        a.id = "abc"
        b.id = "xyz"
        b.completed = true

        #expect(a == b)
    }

    // Checks that tasks are sorted alphabetically by name.
    @Test func sortsByName() {
        let apple = sample(name: "Apple")
        let banana = sample(name: "Banana")
        let cherry = sample(name: "Cherry")

        let sorted = [cherry, apple, banana].sorted()

        #expect(sorted.map(\.name) == [
            "Apple", "Banana", "Cherry"
        ])
    }
}

