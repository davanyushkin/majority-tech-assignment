import Foundation

typealias StoreOf<R: Reducer> = Store<R.State, R.Action>

final class Store<State, Action>: ObservableObject {
    
//    @Published var state: State {
//        didSet {
//            objectWillChange.send()
//        }
//    }
    @Published var state: State
    private let reducer: any Reducer<State, Action>
    
    init (
        initialState: State,
        reducer: any Reducer<State, Action>
    ) {
        self.state = initialState
        self.reducer = reducer
    }
    
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
