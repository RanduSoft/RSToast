import SwiftUI

extension View {
    /// Attaches a toast overlay managed by the given ToastManager.
    public func toast(manager: ToastManager) -> some View {
        modifier(ToastModifier(manager: manager))
    }
}
