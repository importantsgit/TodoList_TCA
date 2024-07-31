//
//  MainCoordinator.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/30/24.
//

import SwiftUI
import Combine
import ComposableArchitecture

final class MainCoordinator: Coordinator {
    private var cancellable = Set<AnyCancellable>()
    private var path: NavigationPath

    var container: MainDependency
    
    init(
        container: MainDependency,
        path: NavigationPath
    ) {
        self.container = container
        self.path = path
    }
    
    func showCountView() -> AnyView {
        container.makeCountView(actions: makeCountAction())
    }
    
    func showTodoView() -> AnyView {
        container.makeTodoListView(actions: makeTodoAction())
    }

    
    private func makeCountAction() -> CountActions {
        let showTodoView = PassthroughSubject<Void, Never>()
        showTodoView.sink { [weak self] _ in
            self?.pop()
        }
        .store(in: &cancellable)
        
        return CountActions(showTodoView: showTodoView)
    }
    
    private func makeTodoAction() -> TodoActions {
        let showCountView = PassthroughSubject<Void, Never>()
        showCountView.sink { [weak self] _ in
            self?.push(.main(.counter))
        }
        .store(in: &cancellable)
        
        return TodoActions(showCountView: showCountView)
    }
    
    // append
    public func push(_ scene: AppScene) {
        path.append(scene)
    }
    
    // 뒤로가기
    public func pop() {
        path.removeLast()
    }
    
    // Root 화면으로 뒤로가기
    public func popToRoot() {
        path.removeLast(path.count)
    }
    

}
