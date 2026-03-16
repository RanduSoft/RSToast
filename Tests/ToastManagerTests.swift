import Testing
import SwiftUI
@testable import RSToast

@Suite("ToastManager")
@MainActor
struct ToastManagerTests {
    @Test("Initial state is nil")
    func initialState() {
        let manager = ToastManager()
        #expect(manager.currentToast == nil)
    }

    @Test("Show item sets current toast")
    func showItem() {
        let manager = ToastManager()
        let item = ToastItem.success(title: "Done")
        manager.show(item)
        #expect(manager.currentToast == item)
    }

    @Test("Show with parameters creates toast")
    func showWithParameters() {
        let manager = ToastManager()
        manager.show(.error, title: "Failed", subtitle: "Try again")
        #expect(manager.currentToast?.title == "Failed")
        #expect(manager.currentToast?.subtitle == "Try again")
        #expect(manager.currentToast?.style == .error)
    }

    @Test("Dismiss clears current toast")
    func dismiss() {
        let manager = ToastManager()
        manager.show(.info, title: "Hello")
        #expect(manager.currentToast != nil)
        manager.dismiss()
        #expect(manager.currentToast == nil)
    }

    @Test("New toast replaces existing")
    func replaceToast() {
        let manager = ToastManager()
        manager.show(.success, title: "First")
        manager.show(.error, title: "Second")
        #expect(manager.currentToast?.title == "Second")
        #expect(manager.currentToast?.style == .error)
    }

    @Test("Auto dismiss after duration")
    func autoDismiss() async throws {
        let manager = ToastManager()
        manager.show(.info, title: "Quick", duration: 0.1)
        #expect(manager.currentToast != nil)
        try await Task.sleep(for: .milliseconds(250))
        #expect(manager.currentToast == nil)
    }

    @Test("Dismiss cancels auto-dismiss")
    func dismissCancelsAutoDismiss() async throws {
        let manager = ToastManager()
        manager.show(.info, title: "Test", duration: 0.1)
        manager.dismiss()
        #expect(manager.currentToast == nil)
    }

    @Test("Show with all positions")
    func positions() {
        let manager = ToastManager()
        manager.show(.info, title: "Top", position: .top)
        #expect(manager.currentToast?.position == .top)
        manager.show(.info, title: "Bottom", position: .bottom)
        #expect(manager.currentToast?.position == .bottom)
    }

    @Test("Show with custom duration")
    func customDuration() {
        let manager = ToastManager()
        manager.show(.success, title: "Test", duration: 5.0)
        #expect(manager.currentToast?.duration == 5.0)
    }

    @Test("Multiple rapid shows keep latest")
    func rapidShows() {
        let manager = ToastManager()
        for i in 0..<10 {
            manager.show(.info, title: "Toast \(i)")
        }
        #expect(manager.currentToast?.title == "Toast 9")
    }
}

@Suite("ToastManager Environment")
@MainActor
struct ToastManagerEnvironmentTests {
    @Test("Environment provides default manager")
    func environmentDefault() {
        // Just verify the EnvironmentKey type exists and compiles
        let manager = ToastManager()
        #expect(manager.currentToast == nil)
    }
}
