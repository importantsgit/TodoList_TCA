//
//  CountFeature.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/29/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CountFeature: Reducer {
    
    // 상태 정의
    // 상태를 관찰 가능하게 만들어, SwiftUI 뷰가 상태 변경을 자동으로 감지하고 UI를 업데이트할 수 있게 함
    @ObservableState
    struct State: Equatable {
        var count = 0
    }
    
    // 액션 정의
    // 사용자 액션이나 effect로 들어온 액션 정의
    enum Action {
        enum SystemAction {
            case dataDidLoad
        }
        
        enum UserAction {
            case incrementButtonTapped
            case decrementButtonTapped
        }
        
        case system(SystemAction)
        case user(UserAction)
    }
    
    // 불투명 반환 타입을 사용하여 Reducer 프로토콜을 준수하는 어떤 타입이든 반환할 수 있음을 의미
    // body 내에서는 하나 이상의 Reducer를 조합할 수 있음
    // 액션이 발생했을 때, 어떻게 상태를 변경하고, 어떤 부작용을 실행할 지 정의

    var body: some Reducer<State, Action> {
        
        // Reduce는 inout State, Action -> Effect<Action>로 초기화 함
        // 따라서 Reduce 내에서 state에 변화를 주면 Feature에 정의된 state의 변경이 이루어지고,
        // 만약 return을 effect인 send(Action)을 반환하면, 다시 Reduce로 들어옴
        // Reduce를 body 내 중복해서 작성 가능함 (순차적으로 실행)
        Reduce { state, action in
            switch action {
            case let .system(action):
                return handleSystemActions(&state, action)
                
                
            case let .user(action):
                return handleUserActions(&state, action)
            }
        }

    }
    
    private func handleSystemActions(
        _ state: inout State,
        _ action: Action.SystemAction
    ) -> Effect<CountFeature.Action> {
        switch action {
        case .dataDidLoad:
            break
        }
        
        return .none
    }
    
    private func handleUserActions(
        _ state: inout State,
        _ action: Action.UserAction
    ) -> Effect<CountFeature.Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            
        case .incrementButtonTapped:
            state.count += 1
        }
        return .none
    }
}

