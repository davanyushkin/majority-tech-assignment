import Foundation

typealias StoreOf<R: Reducer> = Store<R.State, R.Action>

/// Object-typed instance for storing state properly
final class Store<State, Action>: ObservableObject {
    
    @Published var state: State
    private let reducer: any Reducer<State, Action>
    
    init (
        initialState: State,
        reducer: any Reducer<State, Action>
    ) {
        self.state = initialState
        self.reducer = reducer
    }
    
    @MainActor
    func send(_ action: Action) {
        let effect = reducer.reduce(into: &state, action: action)
        
        switch effect {
        case .none:
            break
        case let .run(action):
            action(self.send(_:))
        }
    }
    
}
