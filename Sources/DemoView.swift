import SwiftUI

/// A showcase view demonstrating all RSToast capabilities.
struct DemoView: View {
    @State private var toastManager = ToastManager()

    var body: some View {
        NavigationStack {
            List {
                Section("Styles") {
                    Button("Success") {
                        toastManager.show(.success, title: "Saved!", subtitle: "All changes saved")
                    }
                    Button("Error") {
                        toastManager.show(.error, title: "Failed", subtitle: "Please try again")
                    }
                    Button("Warning") {
                        toastManager.show(.warning, title: "Low battery", subtitle: "Connect charger")
                    }
                    Button("Info") {
                        toastManager.show(.info, title: "Tip", subtitle: "Swipe to dismiss")
                    }
                    Button("Custom") {
                        let toast = ToastItem(
                            style: .custom(systemIcon: "star.fill", tint: .purple),
                            title: "Favourited",
                            subtitle: "Added to your collection"
                        )
                        toastManager.show(toast)
                    }
                }

                Section("Positions") {
                    Button("Top (default)") {
                        toastManager.show(.success, title: "Top toast", position: .top)
                    }
                    Button("Bottom") {
                        toastManager.show(.info, title: "Bottom toast", position: .bottom)
                    }
                }

                Section("Durations") {
                    Button("Short (1s)") {
                        toastManager.show(.info, title: "Quick flash", duration: 1.0)
                    }
                    Button("Default (3s)") {
                        toastManager.show(.info, title: "Standard duration")
                    }
                    Button("Long (6s)") {
                        toastManager.show(.warning, title: "Persistent", subtitle: "Stays for 6 seconds", duration: 6.0)
                    }
                }

                Section("Factory Methods") {
                    Button("ToastItem.success") {
                        toastManager.show(.success(title: "Uploaded", subtitle: "3 files"))
                    }
                    Button("ToastItem.error") {
                        toastManager.show(.error(title: "Connection lost", duration: 5.0))
                    }
                }

                Section("Actions") {
                    Button("Dismiss current toast", role: .destructive) {
                        toastManager.dismiss()
                    }
                }
            }
            .navigationTitle("RSToast Demo")
        }
        .toast(manager: toastManager)
    }
}

#Preview {
    DemoView()
}
