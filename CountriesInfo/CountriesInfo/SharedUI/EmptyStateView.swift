import SwiftUI

/// Default empty-state view in case of some errors happened
struct EmptyStateView: View {
    
    /// Text to display
    let text: String
    /// Action for retry button
    let onTapAction: (() -> ())?
    
    var body: some View {
        VStack {
            Image("ErrorState")
            Text(text)
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding(EdgeInsets(top: .zero, leading: 40, bottom: .zero, trailing: 40))
            if let onTapAction {
                Button("Try again", action: onTapAction)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .clipShape(.capsule)
            }
        }
    }
}
