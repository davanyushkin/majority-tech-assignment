import SwiftUI

/// View modifier to notify about first view's displaying
struct OnFirstAppearViewModifier: ViewModifier {
    let action: () -> ()
    @State private var isAppeared: Bool = false
    
    public func body(content: Content) -> some View {
        content.onAppear {
            guard !isAppeared else { return }
            isAppeared = true
            action()
        }
    }
}

extension View {
    public func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(OnFirstAppearViewModifier(action: action))
    }
}
