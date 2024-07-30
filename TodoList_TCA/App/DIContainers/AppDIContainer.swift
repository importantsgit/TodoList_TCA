//
//  AppDIContainer.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/30/24.
//

import Foundation

protocol AppDependencies {
    func makeMainDependencies(
    ) -> MainDIContainerProtocol
}

final public class AppDIContainer: AppDependencies {
    func makeMainDependencies(
    ) -> MainDIContainerProtocol {
        MainDIContainer()
    }
}
