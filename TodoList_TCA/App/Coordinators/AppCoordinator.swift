//
//  AppCoordinator.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/30/24.
//

import SwiftUI
import Combine
import ComposableArchitecture

enum AppScene: Hashable {
    
    enum MainFlow {
        case counter
        case todo
    }
    
    case main(MainFlow)
}

protocol Coordinator: AnyObject {
    func push(_ scene: AppScene)
    func pop()
    func popToRoot()
}

final public class AppCoordinator: ObservableObject {
    @Published public var path: NavigationPath // 앱 전체에 공유
    private var childCoordinator: [Coordinator] = []
    private let dependencies: AppDependencies
    private let initialScene: AppScene
    
    init(
        dependencies: AppDependencies,
        initialScene: AppScene
    ) {
        self.path = NavigationPath()
        self.initialScene = initialScene
        self.dependencies = dependencies
    }
    
    public func buildInitialScene() -> some View {
        buildScene(scene: initialScene)
    }
    
    public func start() {
        let mainDependencies = dependencies.makeMainDependencies()
        let mainCoordinator = mainDependencies.makeMainCoordinator(path: path)
        childCoordinator.append(mainCoordinator)
    }
    
    @ViewBuilder
    func buildScene(scene: AppScene) -> some View {
        switch scene {
        case let .main(scene):
            if let coordinator = childCoordinator.first(where: { $0 is MainCoordinator}) as? MainCoordinator {
                switch scene {
                case  .counter:
                    coordinator.showCountView()
                    
                case .todo:
                    coordinator.showTodoView()
                }
            }
            
            

        }
    }
}
