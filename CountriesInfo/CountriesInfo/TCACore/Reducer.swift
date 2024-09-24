import Foundation

/// Return type after handling actions. Helps to create required side effects
enum Effect<Action> {
    typealias SendAction = ((Action) -> ())?
    
    case none
    case run(@Sendable (SendAction) -> ())
}

/// Protocol skeleton for reducer element in architecture - responsible for handling view actions as well as state updating
protocol Reducer<State, Action> {
    associatedtype State
    associatedtype Action
    
    @MainActor
    func reduce(into state: inout State, action: Action) -> Effect<Action>
}
