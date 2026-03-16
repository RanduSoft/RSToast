import SwiftUI

struct ToastModifier: ViewModifier {
    @Bindable var manager: ToastManager

    func body(content: Content) -> some View {
        content
            .overlay(alignment: manager.currentToast?.position.alignment ?? .top) {
                if let toast = manager.currentToast {
                    ToastView(item: toast)
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: toast.position.edge)
                                    .combined(with: .opacity),
                                removal: .move(edge: toast.position.edge)
                                    .combined(with: .opacity)
                            )
                        )
                        .padding(toast.position == .top ? .top : .bottom, 8)
                        .onTapGesture {
                            manager.dismiss()
                        }
                        .gesture(
                            DragGesture(minimumDistance: 20)
                                .onEnded { value in
                                    let isSwipeUp = toast.position == .top && value.translation.height < -20
                                    let isSwipeDown = toast.position == .bottom && value.translation.height > 20
                                    if isSwipeUp || isSwipeDown {
                                        manager.dismiss()
                                    }
                                }
                        )
                }
            }
            .animation(.spring(duration: 0.4, bounce: 0.2), value: manager.currentToast?.id)
    }
}
