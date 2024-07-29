### The Composable Architecture

- SwiftUI 프레임워크 선언형 형태에 적합한 뷰 업데이트 방식에 맞는 아키텍처
- 큰 기능들을 분리해 구조적인 모듈로 나누고 이를 이용하는 것이라 판단
- 단방향 데이터 흐름 구조(Uni-directional)를 갖고 있어, 데이터 흐름을 파악하기 쉽고, 상태 변화를 추적하기 쉬움
- 상태 관리를 중앙화 함

### 구조

- State
    - 기능이 로직을 수행하고 UI를 렌더링하는 데 필요한 데이터를 설명하는 타입
    - 앱의 현재 상태를 나타내는 데이터 구조
- Action
    - 기능에서 발생할 수 있는 모든 액션을 나타내는 타입 (알림, 이벤트 소스)
    - 앱에서 발생할 수 있는 모든 이벤트나 사용자 인터랙션을 나타냄
- Reducer
    - 현재 앱의 상태를 주어진 액션에 따라 다음 상태로 발전시키는 방법을 설명하는 함수
    - 또한, API 요청과 같은 실행되어야 할 부작용을 반환하는 책임도 있으며, 이는 Effect 값을 반환함으로써 수행함
- Store
    - 기능을 구동하는 런타임
    - 모든 사용자 액션을 Store에 보내서 Store가 reducer와 effect를 실행 할 수 있게 하며, store에서 state 변화를 관찰하여 UI를 업데이트 할 수 있음

### 과정

1. 유저는 View를 통해 Action(행동)을 보냄
2. Action은 Reducers로 들어감
    - 어떤 Action이 들어왔을 때, 지금 상태(State)를 다음 상태로 변화시키는 방법을 가지고 있는 함수(function)
3. Reducer에서 바로 상태를 변화시켜주거나 (Reducer → State) / 또는 외부 의존성을 가지고 있는 타입으로 접근 (Reducer → Dependency)
    1. 만약 Environment로 접근했다면, Environment는 Effect 타입을 반환
    2. 이 Effect는 다시 Action으로 이어짐

- Store는 State, Reducer, Environment를 모두 감싸고 있음
    - 개발자가 정의한 앱의 모든 기능을 작동하는 공간
    - Store는 Runtime이라고도 불림
