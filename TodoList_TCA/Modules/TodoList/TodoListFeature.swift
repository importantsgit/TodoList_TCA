//
//  TodoListFeature.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/30/24.
//

import Foundation
import Combine
import ComposableArchitecture

struct TodoActions {
    let showCountView: PassthroughSubject<Void, Never>
}

@Reducer
struct TodoListFeature: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var tasks: [Task] = []
    }
    
    enum Action {
        enum ViewAction {
            case initView
            case deleteButtonTapped(Task)
            case updateButtonTapped(Task)
            case insertButtonTapped(Task)
            case dismissButtonTapped
        }
        
        enum ExternalAction {
            case fetchingTask([Task])
            case updateTask(Task)
            case deleteTask(Task)
        }
        
        case view(ViewAction)
        case external(ExternalAction)
    }
    
    private let taskService: TaskServiceInterface
    private let actions: TodoActions
    
    init(
        taskService: TaskServiceInterface,
        actions: TodoActions
    ) {
        self.taskService = taskService
        self.actions = actions
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                return handleUserAction(&state, action)
            
            case let .external(action):
                return handleSystemActions(&state, action)
            }
        }
    }
    
    private func handleUserAction(
        _ state: inout State,
        _ action: Action.ViewAction
    ) -> Effect<TodoListFeature.Action> {
        
        switch action {
        case .initView:
            return .run { send in
                let tasks = try await taskService.getTasks()
                await send.callAsFunction(.external(.fetchingTask(tasks)))
            }
            
        case let .deleteButtonTapped(task):
            return .run { send in
                try await taskService.deleteTask(task)
                await send.callAsFunction(.external(.deleteTask(task)))
            }
            
        case .updateButtonTapped(let task), .insertButtonTapped(let task):
            if state.tasks.contains(task) {
                return .none
            }
            
            return .run { send in
                do {
                    try await taskService.updateTask(task)
                }
                catch {
                    print(error.localizedDescription)
                }
                
                await send.callAsFunction(.external(.updateTask(task)))
            }

        case .dismissButtonTapped:
            actions.showCountView.send()

        }
        
        return .none
    }
    
    private func handleSystemActions(
        _ state: inout State,
        _ action: Action.ExternalAction
    ) -> Effect<TodoListFeature.Action> {

        switch action {
        case let .fetchingTask(tasks):
            state.tasks = tasks
            
        case let .deleteTask(task):
            if let index = state.tasks.firstIndex(where: { $0.title == task.title }) {
                state.tasks.remove(at: index)
            }
            
        case let .updateTask(task):
            // Task가 존재할 때
            if let index = state.tasks.firstIndex(where: { $0.title == task.title }) {
                state.tasks[index] = task
            }
            // Task가 존재하지 않을 때
            else {
                state.tasks.append(task)
            }
            
        }
        
        return .none
    }
}
