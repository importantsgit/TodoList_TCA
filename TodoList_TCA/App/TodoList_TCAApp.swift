//
//  TodoList_TCAApp.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/29/24.
//

import SwiftUI
import SwiftData

@main
struct TodoList_TCAApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Task.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    private let DIContainer: AppDIContainer
    @ObservedObject private var coordinator: AppCoordinator
    
    init() {
        self.DIContainer = AppDIContainer()
        self.coordinator = AppCoordinator(
            dependencies: DIContainer,
            initialScene: .main(.counter)
        )
        
        self.coordinator.start()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.buildInitialScene()
                    .navigationDestination(for: AppScene.self) { scene in
                        coordinator.buildScene(scene: scene)
                    }
            }
        }
        //.modelContainer(sharedModelContainer)
    }
}
