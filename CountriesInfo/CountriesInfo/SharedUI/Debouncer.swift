import Foundation

final class Debouncer {
    private let duration: ContinuousClock.Duration
    
    init(duration: ContinuousClock.Duration) {
        self.duration = duration
    }
    
    func emit(block: @Sendable @escaping () async -> Void) {
        Task { [duration, block] in
            try? await Task.sleep(for: duration)
            await block()
        }
    }
}
