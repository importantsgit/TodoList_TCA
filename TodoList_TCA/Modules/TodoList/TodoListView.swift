//
//  TodoListView.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/30/24.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct TodoListView: View {
    
    let store: StoreOf<TodoListFeature>
    
    var body: some View {
        HStack {
            Button {
                store.send(.view(.dismissButtonTapped))
            } label: {
                Text("dismissButtonTapped")
            }
        }
    }
}

#Preview {
    TodoListView(
        store: Store(initialState: TodoListFeature.State(), reducer: {
            TodoListFeature(
                taskService: TaskServiceMock(),
                actions: .init(showCountView: PassthroughSubject<Void, Never>())
            )
        })
    )
}
