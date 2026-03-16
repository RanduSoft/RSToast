import UIKit
import SwiftUI

extension UIViewController {

    private static let toastManagerKey = malloc(1)!

    /// Returns or creates a ToastManager associated with this view controller.
    @MainActor
    public var toastManager: ToastManager {
        if let existing = objc_getAssociatedObject(self, Self.toastManagerKey) as? ToastManager {
            return existing
        }
        let manager = ToastManager()
        objc_setAssociatedObject(self, Self.toastManagerKey, manager, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        installToastOverlay(manager: manager)
        return manager
    }

    @MainActor
    private func installToastOverlay(manager: ToastManager) {
        let overlayView = Color.clear.toast(manager: manager)
        let hostingController = UIHostingController(rootView: overlayView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.isUserInteractionEnabled = true

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }

    /// Show a toast from UIKit with a pre-built ToastItem.
    @MainActor
    public func showToast(_ item: ToastItem) {
        toastManager.show(item)
    }

    /// Show a toast from UIKit with inline parameters.
    @MainActor
    public func showToast(
        _ style: ToastStyle,
        title: String,
        subtitle: String? = nil,
        duration: TimeInterval = 3.0,
        position: ToastPosition = .top
    ) {
        toastManager.show(style, title: title, subtitle: subtitle, duration: duration, position: position)
    }

    /// Dismiss any visible toast.
    @MainActor
    public func dismissToast() {
        toastManager.dismiss()
    }
}
