//
//  Task.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/29/24.
//

import Foundation
import SwiftData

@Model
final class Task {
    @Attribute(.unique) var title: String
    let isChecked: Bool = false
    
    init(title: String) {
        self.title = title
    }
}
