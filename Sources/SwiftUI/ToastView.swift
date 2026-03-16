import SwiftUI

struct ToastView: View {
    let item: ToastItem

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.style.iconName)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(item.style.tintColor)

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)

                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            Capsule()
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 5)
        }
    }
}
