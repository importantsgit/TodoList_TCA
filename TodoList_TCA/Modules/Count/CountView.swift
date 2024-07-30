//
//  CountView.swift
//  TodoList_TCA
//
//  Created by 이재훈 on 7/29/24.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct CountView: View {
    
    // store: 실제 기능이 작동하는 공간: Runtime이라고도 불림
    // CountFeature의 State와 Action을 사용하는 Store 생성됨
    let store: StoreOf<CountFeature> // let으로 선언하여 store를 조작할 수 없게 함
    // store의 state 프로퍼티가 읽힐 때마다 SwiftUI에 이 프로퍼티를 사용 중이라고 알림
    // store의 state 프로퍼티가 변경 될 때, SwiftUI에 이 프로퍼티가 변경 됨을 알림
    
    var body: some View {
        VStack {
            Text("\(store.count)")  // store의 count 접근: ObservableState이기 때문에 관찰 가능한 값
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                
            
            HStack {
                Button("-") {
                    store.send(.user(.decrementButtonTapped))
                }
                .padding()
                .background(Color.black.opacity(0.1))
                .clipShape(.rect(cornerRadius: 10))
                
                Button("+") {
                    store.send(.user(.incrementButtonTapped))
                }
                .padding()
                .background(Color.black.opacity(0.1))
                .clipShape(.rect(cornerRadius: 10))
            }
            
            Button {
                store.send(.user(.dismissButtonTapped))
            } label: {
                Text("dismissButtonTapped")
            }
        }
    }
}

#Preview {
    CountView(
        store: Store (initialState: CountFeature.State()) {
            CountFeature(actions: .init(showTodoView: PassthroughSubject<Void, Never>()))
                ._printChanges() // 디버깅용 메서드
        }
    )
}
