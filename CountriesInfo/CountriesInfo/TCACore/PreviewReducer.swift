import Foundation

struct PreviewReducer<State, Action>: Reducer {
    let handle: (inout State, Action) -> Effect<Action>
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        handle(&state, action)
    }
}
