# RSToast

A modern, Apple-style toast notification library for SwiftUI and UIKit.

Built with Swift 6, strict concurrency, and targeting iOS 18+.

![RSToast Demo](https://i.imgur.com/LulCsUi.gif)

## Features

- Apple-style frosted glass pill design with SF Symbols
- Spring animations with swipe and tap to dismiss
- Auto-dismiss with configurable duration
- Haptic feedback support
- `@Observable` state management with `ToastManager`
- SwiftUI-first with full UIKit support
- Swift 6 strict concurrency safe

## Installation

Add RSToast to your project via Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/RanduSoft/RSToast.git", from: "1.0.0")
]
```

## Usage

### SwiftUI

```swift
import RSToast

struct ContentView: View {
    @State private var toastManager = ToastManager()

    var body: some View {
        VStack(spacing: 20) {
            Button("Success") {
                toastManager.show(.success, title: "Saved!")
            }

            Button("Error") {
                toastManager.show(.error, title: "Failed", subtitle: "Please try again")
            }

            Button("Bottom Warning") {
                toastManager.show(.warning, title: "Low battery", position: .bottom)
            }
        }
        .toast(manager: toastManager)
    }
}
```

### Using Factory Methods

```swift
let toast = ToastItem.success(title: "Uploaded", subtitle: "3 files")
toastManager.show(toast)

let error = ToastItem.error(title: "Connection lost", duration: 5.0)
toastManager.show(error)
```

### Environment Access

```swift
struct ChildView: View {
    @Environment(\.toastManager) var toastManager

    var body: some View {
        Button("Show Toast") {
            toastManager.show(.info, title: "Tip", subtitle: "Swipe up to dismiss")
        }
    }
}
```

### UIKit

```swift
import RSToast

class ViewController: UIViewController {
    func onSave() {
        showToast(.success, title: "Saved!")
    }

    func onError() {
        showToast(.error, title: "Failed", subtitle: "Try again", duration: 5.0)
    }

    func onDismiss() {
        dismissToast()
    }
}
```

## Toast Styles

| Style | Icon | Color |
|-------|------|-------|
| `.success` | checkmark.circle.fill | Green |
| `.error` | xmark.circle.fill | Red |
| `.warning` | exclamationmark.triangle.fill | Orange |
| `.info` | info.circle.fill | Blue |
| `.custom(systemIcon:tint:)` | Any SF Symbol | Any Color |

## Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `title` | required | Main toast text |
| `subtitle` | `nil` | Secondary text below the title |
| `duration` | `3.0` | Auto-dismiss delay in seconds |
| `position` | `.top` | `.top` or `.bottom` |
| `haptic` | varies | Haptic feedback type (auto-set by factory methods) |

## Dismissal

Toasts can be dismissed by:

- **Auto-dismiss** after the configured duration
- **Tap** anywhere on the toast
- **Swipe** up (for top toasts) or down (for bottom toasts)
- **Programmatically** via `toastManager.dismiss()`

## Requirements

- iOS 17.0+
- Swift 6.0+
- Xcode 16.0+

## License

[MIT](LICENSE)
