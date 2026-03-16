import SwiftUI

/// Defines the visual style of a toast notification.
public enum ToastStyle: Sendable, Equatable {
    case success
    case error
    case warning
    case info
    case custom(systemIcon: String, tint: Color)

    var iconName: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .info:
            return "info.circle.fill"
        case .custom(let systemIcon, _):
            return systemIcon
        }
    }

    var tintColor: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .warning:
            return .orange
        case .info:
            return .blue
        case .custom(_, let tint):
            return tint
        }
    }
}
