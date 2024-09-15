import Foundation

enum Effect<Action> {
    typealias SendAction = ((Action) -> ())?
    
    case none
    case run(@Sendable (SendAction) -> ())
}

protocol Reducer<State, Action> {
    associatedtype State
    associatedtype Action
    
    func reduce(into state: inout State, action: Action) -> Effect<Action>
}
