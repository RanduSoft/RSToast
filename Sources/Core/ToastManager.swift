import SwiftUI
import Observation

@Observable
@MainActor
public final class ToastManager {
    public private(set) var currentToast: ToastItem?
    private var dismissTask: Task<Void, Never>?

    nonisolated public init() {}

    /// Show a toast with full control
    public func show(_ item: ToastItem) {
        dismissTask?.cancel()
        currentToast = item
        triggerHaptic(item.haptic)
        scheduleDismiss(after: item.duration)
    }

    /// Show a toast with inline parameters
    public func show(
        _ style: ToastStyle,
        title: String,
        subtitle: String? = nil,
        duration: TimeInterval = 3.0,
        position: ToastPosition = .top
    ) {
        let item = ToastItem(style: style, title: title, subtitle: subtitle, duration: duration, position: position)
        show(item)
    }

    /// Dismiss the current toast
    public func dismiss() {
        dismissTask?.cancel()
        currentToast = nil
    }

    private func scheduleDismiss(after duration: TimeInterval) {
        dismissTask = Task { [weak self] in
            try? await Task.sleep(for: .seconds(duration))
            guard !Task.isCancelled else { return }
            self?.currentToast = nil
        }
    }

    private func triggerHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType?) {
        guard let type else { return }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

// MARK: - Environment

private struct ToastManagerKey: EnvironmentKey {
    static let defaultValue = ToastManager()
}

extension EnvironmentValues {
    public var toastManager: ToastManager {
        get { self[ToastManagerKey.self] }
        set { self[ToastManagerKey.self] = newValue }
    }
}
