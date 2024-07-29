//
//  ContentView.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/29/24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(tasks) { task in
                    NavigationLink {
                        Text("Item at \(task.title)")
                    } label: {
                        Text(task.title)
                    }
                }
                .onDelete(perform: deleteTasks)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addTask) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func modifyTask() {
        withAnimation {

        }
    }

    private func addTask() {
        withAnimation {
            let newItem = Task(title: "hello\(Int.random(in: 0...1000))")
            modelContext.insert(newItem)
        }
    }

    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(tasks[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}


