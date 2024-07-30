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
            case dismissButtonTapped
        }
        
        enum ExternalAction {
            
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
        default: break
        }
        
        return .none
    }
    

}
