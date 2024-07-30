//
//  MainDIContainer.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/30/24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

protocol MainDependency {
    func makeCountView(actions: CountActions) -> AnyView
    func makeTodoListView(actions: TodoActions) -> AnyView
}

protocol MainDIContainerProtocol {
    func makeMainCoordinator(
        path: NavigationPath
    ) -> MainCoordinator
}


class MainDIContainer: MainDIContainerProtocol, MainDependency {
    
    lazy var modelContainer: ModelContainer = {
        let schema = Schema([Task.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        return try! ModelContainer(for: schema, configurations: [modelConfiguration])
    }()
    
    func makeMainCoordinator(
        path: NavigationPath
    ) -> MainCoordinator {
        .init(container: self, path: path)
    }
    
    @MainActor func makeTaskService() -> TaskServiceInterface {
        TaskService(container: modelContainer)
    }
    
    // MARK: - Store
    
    func makeCountStore(
        actions: CountActions
    ) -> StoreOf<CountFeature> {
        Store(initialState: CountFeature.State()) {
            CountFeature(actions: actions)
        }
    }
    
    @MainActor
    func makeTodoListStore(
        actions: TodoActions
    ) -> StoreOf<TodoListFeature> {
        Store(initialState: TodoListFeature.State()) {
            TodoListFeature(
                taskService: makeTaskService(),
                actions: actions
            )
        }
    }
    
    // MARK: - View
    
    func makeCountView(
        actions: CountActions
    ) -> AnyView  {
        AnyView(CountView(store: makeCountStore(actions: actions)))
    }
    
    @MainActor
    func makeTodoListView(
        actions: TodoActions
    ) -> AnyView  {
        AnyView(TodoListView(store: makeTodoListStore(actions: actions)))
    }
}

