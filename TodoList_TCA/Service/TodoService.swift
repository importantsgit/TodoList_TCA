//
//  TodoService.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/30/24.
//

import Foundation
import SwiftData

enum TaskError: Error {
    case notMatch
}

protocol TaskServiceInterface {
    func getTasks() async throws -> [Task]
    func addTask(_ task: Task) async throws
    func updateTask(_ task: Task) async throws
    func deleteTask(_ task: Task) async throws
}

@MainActor
final class TaskService: TaskServiceInterface {
    
    private let container: ModelContainer
    
    
    private var context: ModelContext {
        container.mainContext
    }
    
    init(container: ModelContainer) {
        self.container = container
    }

    func getTasks() async throws -> [Task] {
        let descriptor = FetchDescriptor<Task>(sortBy: [.init(\.title)])
        return try context.fetch(descriptor)
    }
    
    func addTask(_ task: Task) async throws {
        context.insert(task)
        try context.save()
    }
    
    func updateTask(_ task: Task) async throws {
//        
//        let tasks = try context.fetch(FetchDescriptor<Task>(predicate: #Predicate<Task> { $0.id == task.id }))
//        guard let updatingTask = tasks.first
//        else { throw TaskError.notMatch }
//        
//        updatingTask.title = task.title
//        updatingTask.isChecked = task.isChecked
//        
//        try context.save()
    }
    
    func deleteTask(_ task: Task) async throws {
//        guard let compareTask = try context.fetch(FetchDescriptor<Task>(predicate: #Predicate<Task> { $0.id == task.id })).first
//        else { throw TaskError.notMatch }
//        
//        if compareTask == task {
//            context.delete(compareTask)
//            try context.save()
//        }
//        else {
//            throw TaskError.notMatch
//        }
    }
}

final class TaskServiceMock: TaskServiceInterface {
    
    var getTasksCallCount = 0
    func getTasks() async throws -> [Task] {
        getTasksCallCount += 1
        return [.init(title: "hello")]
    }
    
    var addTaskCallCount = 0
    func addTask(_ task: Task) async throws {
        addTaskCallCount += 1
    }
    
    var updateTaskCallCount = 0
    func updateTask(_ task: Task) async throws {
        updateTaskCallCount += 1
    }
    
    var deleteTaskCallCount = 0
    func deleteTask(_ task: Task) async throws {
        deleteTaskCallCount += 1
    }
    
    
}
