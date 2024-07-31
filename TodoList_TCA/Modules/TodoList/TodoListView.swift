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
    @State private var newTaskTitle: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("New task", text: $newTaskTitle)
                Button("Add") {
                    let newTask = Task(title: newTaskTitle)
                    store.send(.view(.insertButtonTapped(newTask)))
                    newTaskTitle = ""
                }
                .disabled(newTaskTitle.isEmpty)
            }
            .padding()

            Button("Dismiss") {
                store.send(.view(.dismissButtonTapped))
            }
            
            List {
                ForEach(store.tasks, id: \.title) { task in
                    HStack {
                        Text(task.title)
                        Spacer()
                        Button(action: {
                            store.send(.view(.deleteButtonTapped(task)))
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }


        }
        .navigationTitle("Todo List")
        .onAppear {
            store.send(.view(.initView))
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
