import SwiftUI

/// Represents a single toast notification to be displayed.
public struct ToastItem: Identifiable, Sendable, Equatable {
    public let id: UUID
    public let style: ToastStyle
    public let title: String
    public let subtitle: String?
    public let duration: TimeInterval
    public let position: ToastPosition
    public let haptic: UINotificationFeedbackGenerator.FeedbackType?

    public init(
        style: ToastStyle,
        title: String,
        subtitle: String? = nil,
        duration: TimeInterval = 3.0,
        position: ToastPosition = .top,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil
    ) {
        self.id = UUID()
        self.style = style
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
        self.position = position
        self.haptic = haptic
    }
}

// MARK: - Convenience Factory Methods

public extension ToastItem {

    static func success(
        title: String,
        subtitle: String? = nil,
        duration: TimeInterval = 3.0,
        position: ToastPosition = .top
    ) -> ToastItem {
        ToastItem(
            style: .success,
            title: title,
            subtitle: subtitle,
            duration: duration,
            position: position,
            haptic: .success
        )
    }

    static func error(
        title: String,
        subtitle: String? = nil,
        duration: TimeInterval = 3.0,
        position: ToastPosition = .top
    ) -> ToastItem {
        ToastItem(
            style: .error,
            title: title,
            subtitle: subtitle,
            duration: duration,
            position: position,
            haptic: .error
        )
    }

    static func warning(
        title: String,
        subtitle: String? = nil,
        duration: TimeInterval = 3.0,
        position: ToastPosition = .top
    ) -> ToastItem {
        ToastItem(
            style: .warning,
            title: title,
            subtitle: subtitle,
            duration: duration,
            position: position,
            haptic: .warning
        )
    }

    static func info(
        title: String,
        subtitle: String? = nil,
        duration: TimeInterval = 3.0,
        position: ToastPosition = .top
    ) -> ToastItem {
        ToastItem(
            style: .info,
            title: title,
            subtitle: subtitle,
            duration: duration,
            position: position,
            haptic: nil
        )
    }
}
