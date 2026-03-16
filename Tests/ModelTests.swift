// ModelTests.swift
// RSToastTests
//
// Comprehensive unit tests for RSToast model types using Swift Testing framework.

import Testing
import SwiftUI
@testable import RSToast

// MARK: - ToastStyle Tests

@Suite("ToastStyle")
struct ToastStyleTests {

    // MARK: iconName

    @Suite("iconName")
    struct IconNameTests {

        @Test("success returns checkmark.circle.fill")
        func successIconName() {
            #expect(ToastStyle.success.iconName == "checkmark.circle.fill")
        }

        @Test("error returns xmark.circle.fill")
        func errorIconName() {
            #expect(ToastStyle.error.iconName == "xmark.circle.fill")
        }

        @Test("warning returns exclamationmark.triangle.fill")
        func warningIconName() {
            #expect(ToastStyle.warning.iconName == "exclamationmark.triangle.fill")
        }

        @Test("info returns info.circle.fill")
        func infoIconName() {
            #expect(ToastStyle.info.iconName == "info.circle.fill")
        }

        @Test("custom returns the provided systemIcon string")
        func customIconName() {
            let style = ToastStyle.custom(systemIcon: "star.fill", tint: .purple)
            #expect(style.iconName == "star.fill")
        }

        @Test("custom with different icon string returns that icon string")
        func customIconNameVariant() {
            let style = ToastStyle.custom(systemIcon: "bolt.fill", tint: .yellow)
            #expect(style.iconName == "bolt.fill")
        }

        @Test("custom with empty string returns empty string")
        func customIconNameEmpty() {
            let style = ToastStyle.custom(systemIcon: "", tint: .gray)
            #expect(style.iconName == "")
        }
    }

    // MARK: tintColor

    @Suite("tintColor")
    struct TintColorTests {

        @Test("success tintColor is green")
        func successTintColor() {
            #expect(ToastStyle.success.tintColor == .green)
        }

        @Test("error tintColor is red")
        func errorTintColor() {
            #expect(ToastStyle.error.tintColor == .red)
        }

        @Test("warning tintColor is orange")
        func warningTintColor() {
            #expect(ToastStyle.warning.tintColor == .orange)
        }

        @Test("info tintColor is blue")
        func infoTintColor() {
            #expect(ToastStyle.info.tintColor == .blue)
        }

        @Test("custom tintColor returns the associated tint")
        func customTintColor() {
            let style = ToastStyle.custom(systemIcon: "star.fill", tint: .purple)
            #expect(style.tintColor == .purple)
        }

        @Test("custom tintColor with pink returns pink")
        func customTintColorPink() {
            let style = ToastStyle.custom(systemIcon: "heart.fill", tint: .pink)
            #expect(style.tintColor == .pink)
        }

        @Test("custom tintColor with yellow returns yellow")
        func customTintColorYellow() {
            let style = ToastStyle.custom(systemIcon: "bolt.fill", tint: .yellow)
            #expect(style.tintColor == .yellow)
        }
    }

    // MARK: Equatable

    @Suite("Equatable conformance")
    struct EquatableTests {

        @Test("same simple cases are equal")
        func simpleCasesEqual() {
            #expect(ToastStyle.success == ToastStyle.success)
            #expect(ToastStyle.error == ToastStyle.error)
            #expect(ToastStyle.warning == ToastStyle.warning)
            #expect(ToastStyle.info == ToastStyle.info)
        }

        @Test("different simple cases are not equal")
        func simpleCasesNotEqual() {
            #expect(ToastStyle.success != ToastStyle.error)
            #expect(ToastStyle.success != ToastStyle.warning)
            #expect(ToastStyle.success != ToastStyle.info)
            #expect(ToastStyle.error != ToastStyle.warning)
            #expect(ToastStyle.error != ToastStyle.info)
            #expect(ToastStyle.warning != ToastStyle.info)
        }

        @Test("custom cases with same values are equal")
        func customCasesEqualSameValues() {
            let a = ToastStyle.custom(systemIcon: "star.fill", tint: .purple)
            let b = ToastStyle.custom(systemIcon: "star.fill", tint: .purple)
            #expect(a == b)
        }

        @Test("custom cases with different icons are not equal")
        func customCasesNotEqualDifferentIcon() {
            let a = ToastStyle.custom(systemIcon: "star.fill", tint: .purple)
            let b = ToastStyle.custom(systemIcon: "bolt.fill", tint: .purple)
            #expect(a != b)
        }

        @Test("custom cases with different tints are not equal")
        func customCasesNotEqualDifferentTint() {
            let a = ToastStyle.custom(systemIcon: "star.fill", tint: .purple)
            let b = ToastStyle.custom(systemIcon: "star.fill", tint: .pink)
            #expect(a != b)
        }

        @Test("custom case is not equal to a simple case")
        func customNotEqualToSimple() {
            let custom = ToastStyle.custom(systemIcon: "checkmark.circle.fill", tint: .green)
            #expect(custom != ToastStyle.success)
        }

        @Test("simple case is not equal to custom case")
        func simpleNotEqualToCustom() {
            let custom = ToastStyle.custom(systemIcon: "xmark.circle.fill", tint: .red)
            #expect(ToastStyle.error != custom)
        }
    }

    // MARK: Sendable

    @Test("ToastStyle values can be sent across concurrency boundaries")
    func sendable() async {
        let styles: [ToastStyle] = [.success, .error, .warning, .info,
                                    .custom(systemIcon: "star.fill", tint: .purple)]
        let results = await withTaskGroup(of: String.self, returning: [String].self) { group in
            for style in styles {
                group.addTask { style.iconName }
            }
            var collected: [String] = []
            for await name in group { collected.append(name) }
            return collected
        }
        #expect(results.count == 5)
    }
}

// MARK: - ToastPosition Tests

@Suite("ToastPosition")
struct ToastPositionTests {

    // MARK: alignment

    @Suite("alignment")
    struct AlignmentTests {

        @Test("top position has top alignment")
        func topAlignment() {
            #expect(ToastPosition.top.alignment == .top)
        }

        @Test("bottom position has bottom alignment")
        func bottomAlignment() {
            #expect(ToastPosition.bottom.alignment == .bottom)
        }

        @Test("top and bottom alignments are different")
        func alignmentsAreDifferent() {
            #expect(ToastPosition.top.alignment != ToastPosition.bottom.alignment)
        }
    }

    // MARK: edge

    @Suite("edge")
    struct EdgeTests {

        @Test("top position has top edge")
        func topEdge() {
            #expect(ToastPosition.top.edge == .top)
        }

        @Test("bottom position has bottom edge")
        func bottomEdge() {
            #expect(ToastPosition.bottom.edge == .bottom)
        }

        @Test("top and bottom edges are different")
        func edgesAreDifferent() {
            #expect(ToastPosition.top.edge != ToastPosition.bottom.edge)
        }
    }

    // MARK: Sendable

    @Test("ToastPosition values can be sent across concurrency boundaries")
    func sendable() async {
        let position: ToastPosition = .top
        let edge = await Task { position.edge }.value
        #expect(edge == .top)
    }
}

// MARK: - ToastItem Tests

@Suite("ToastItem")
struct ToastItemTests {

    // MARK: Designated initializer defaults

    @Suite("Designated initializer defaults")
    struct InitDefaultsTests {

        @Test("subtitle defaults to nil")
        func subtitleDefaultsToNil() {
            let item = ToastItem(style: .success, title: "Done")
            #expect(item.subtitle == nil)
        }

        @Test("duration defaults to 3.0")
        func durationDefaultsToThree() {
            let item = ToastItem(style: .success, title: "Done")
            #expect(item.duration == 3.0)
        }

        @Test("position defaults to top")
        func positionDefaultsToTop() {
            let item = ToastItem(style: .success, title: "Done")
            #expect(item.position == .top)
        }

        @Test("haptic defaults to nil")
        func hapticDefaultsToNil() {
            let item = ToastItem(style: .success, title: "Done")
            #expect(item.haptic == nil)
        }

        @Test("style is stored correctly")
        func styleStored() {
            let item = ToastItem(style: .error, title: "Oops")
            #expect(item.style == .error)
        }

        @Test("title is stored correctly")
        func titleStored() {
            let item = ToastItem(style: .info, title: "FYI")
            #expect(item.title == "FYI")
        }
    }

    // MARK: Designated initializer explicit values

    @Suite("Designated initializer explicit values")
    struct InitExplicitTests {

        @Test("explicit subtitle is stored")
        func explicitSubtitle() {
            let item = ToastItem(style: .info, title: "Title", subtitle: "Sub")
            #expect(item.subtitle == "Sub")
        }

        @Test("explicit duration is stored")
        func explicitDuration() {
            let item = ToastItem(style: .info, title: "Title", duration: 5.0)
            #expect(item.duration == 5.0)
        }

        @Test("explicit position bottom is stored")
        func explicitPositionBottom() {
            let item = ToastItem(style: .info, title: "Title", position: .bottom)
            #expect(item.position == .bottom)
        }

        @Test("explicit haptic is stored")
        func explicitHaptic() {
            let item = ToastItem(style: .warning, title: "Careful", haptic: .warning)
            #expect(item.haptic == .warning)
        }

        @Test("all explicit values are stored together")
        func allExplicitValues() {
            let item = ToastItem(
                style: .custom(systemIcon: "star.fill", tint: .purple),
                title: "Custom",
                subtitle: "Detail",
                duration: 7.5,
                position: .bottom,
                haptic: .success
            )
            #expect(item.style == .custom(systemIcon: "star.fill", tint: .purple))
            #expect(item.title == "Custom")
            #expect(item.subtitle == "Detail")
            #expect(item.duration == 7.5)
            #expect(item.position == .bottom)
            #expect(item.haptic == .success)
        }
    }

    // MARK: Identifiable (UUID generation)

    @Suite("Identifiable - UUID generation")
    struct IdentifiableTests {

        @Test("each init generates a unique id")
        func uniqueIDs() {
            let a = ToastItem(style: .success, title: "Toast")
            let b = ToastItem(style: .success, title: "Toast")
            #expect(a.id != b.id)
        }

        @Test("id is a valid UUID (non-nil)")
        func validID() {
            let item = ToastItem(style: .info, title: "Info")
            // UUID is a value type; we verify it has a meaningful string representation
            #expect(item.id.uuidString.isEmpty == false)
        }

        @Test("factory-created items have unique ids")
        func factoryUniqueIDs() {
            let a = ToastItem.success(title: "A")
            let b = ToastItem.success(title: "A")
            #expect(a.id != b.id)
        }

        @Test("items with same content have different ids")
        func sameContentDifferentIDs() {
            let items = (0..<10).map { _ in ToastItem(style: .info, title: "Same") }
            let uniqueIDs = Set(items.map(\.id))
            #expect(uniqueIDs.count == 10)
        }
    }

    // MARK: Static factory - success

    @Suite("Static factory .success")
    struct SuccessFactoryTests {

        @Test("style is success")
        func style() {
            let item = ToastItem.success(title: "Saved")
            #expect(item.style == .success)
        }

        @Test("title is stored")
        func title() {
            let item = ToastItem.success(title: "Saved!")
            #expect(item.title == "Saved!")
        }

        @Test("subtitle defaults to nil")
        func subtitleDefault() {
            let item = ToastItem.success(title: "Saved")
            #expect(item.subtitle == nil)
        }

        @Test("explicit subtitle is stored")
        func explicitSubtitle() {
            let item = ToastItem.success(title: "Saved", subtitle: "All changes saved")
            #expect(item.subtitle == "All changes saved")
        }

        @Test("duration defaults to 3.0")
        func durationDefault() {
            let item = ToastItem.success(title: "Saved")
            #expect(item.duration == 3.0)
        }

        @Test("explicit duration is stored")
        func explicitDuration() {
            let item = ToastItem.success(title: "Saved", duration: 2.0)
            #expect(item.duration == 2.0)
        }

        @Test("position defaults to top")
        func positionDefault() {
            let item = ToastItem.success(title: "Saved")
            #expect(item.position == .top)
        }

        @Test("explicit position bottom is stored")
        func explicitPosition() {
            let item = ToastItem.success(title: "Saved", position: .bottom)
            #expect(item.position == .bottom)
        }

        @Test("haptic defaults to .success")
        func hapticDefault() {
            let item = ToastItem.success(title: "Saved")
            #expect(item.haptic == .success)
        }
    }

    // MARK: Static factory - error

    @Suite("Static factory .error")
    struct ErrorFactoryTests {

        @Test("style is error")
        func style() {
            let item = ToastItem.error(title: "Failed")
            #expect(item.style == .error)
        }

        @Test("title is stored")
        func title() {
            let item = ToastItem.error(title: "Network error")
            #expect(item.title == "Network error")
        }

        @Test("subtitle defaults to nil")
        func subtitleDefault() {
            let item = ToastItem.error(title: "Failed")
            #expect(item.subtitle == nil)
        }

        @Test("explicit subtitle is stored")
        func explicitSubtitle() {
            let item = ToastItem.error(title: "Failed", subtitle: "Try again")
            #expect(item.subtitle == "Try again")
        }

        @Test("duration defaults to 3.0")
        func durationDefault() {
            let item = ToastItem.error(title: "Failed")
            #expect(item.duration == 3.0)
        }

        @Test("explicit duration is stored")
        func explicitDuration() {
            let item = ToastItem.error(title: "Failed", duration: 4.5)
            #expect(item.duration == 4.5)
        }

        @Test("position defaults to top")
        func positionDefault() {
            let item = ToastItem.error(title: "Failed")
            #expect(item.position == .top)
        }

        @Test("explicit position is stored")
        func explicitPosition() {
            let item = ToastItem.error(title: "Failed", position: .bottom)
            #expect(item.position == .bottom)
        }

        @Test("haptic defaults to .error")
        func hapticDefault() {
            let item = ToastItem.error(title: "Failed")
            #expect(item.haptic == .error)
        }
    }

    // MARK: Static factory - warning

    @Suite("Static factory .warning")
    struct WarningFactoryTests {

        @Test("style is warning")
        func style() {
            let item = ToastItem.warning(title: "Heads up")
            #expect(item.style == .warning)
        }

        @Test("title is stored")
        func title() {
            let item = ToastItem.warning(title: "Low storage")
            #expect(item.title == "Low storage")
        }

        @Test("subtitle defaults to nil")
        func subtitleDefault() {
            let item = ToastItem.warning(title: "Heads up")
            #expect(item.subtitle == nil)
        }

        @Test("explicit subtitle is stored")
        func explicitSubtitle() {
            let item = ToastItem.warning(title: "Heads up", subtitle: "Please review")
            #expect(item.subtitle == "Please review")
        }

        @Test("duration defaults to 3.0")
        func durationDefault() {
            let item = ToastItem.warning(title: "Heads up")
            #expect(item.duration == 3.0)
        }

        @Test("explicit duration is stored")
        func explicitDuration() {
            let item = ToastItem.warning(title: "Heads up", duration: 6.0)
            #expect(item.duration == 6.0)
        }

        @Test("position defaults to top")
        func positionDefault() {
            let item = ToastItem.warning(title: "Heads up")
            #expect(item.position == .top)
        }

        @Test("explicit position is stored")
        func explicitPosition() {
            let item = ToastItem.warning(title: "Heads up", position: .bottom)
            #expect(item.position == .bottom)
        }

        @Test("haptic defaults to .warning")
        func hapticDefault() {
            let item = ToastItem.warning(title: "Heads up")
            #expect(item.haptic == .warning)
        }
    }

    // MARK: Static factory - info

    @Suite("Static factory .info")
    struct InfoFactoryTests {

        @Test("style is info")
        func style() {
            let item = ToastItem.info(title: "FYI")
            #expect(item.style == .info)
        }

        @Test("title is stored")
        func title() {
            let item = ToastItem.info(title: "Version 2.0 available")
            #expect(item.title == "Version 2.0 available")
        }

        @Test("subtitle defaults to nil")
        func subtitleDefault() {
            let item = ToastItem.info(title: "FYI")
            #expect(item.subtitle == nil)
        }

        @Test("explicit subtitle is stored")
        func explicitSubtitle() {
            let item = ToastItem.info(title: "FYI", subtitle: "More details here")
            #expect(item.subtitle == "More details here")
        }

        @Test("duration defaults to 3.0")
        func durationDefault() {
            let item = ToastItem.info(title: "FYI")
            #expect(item.duration == 3.0)
        }

        @Test("explicit duration is stored")
        func explicitDuration() {
            let item = ToastItem.info(title: "FYI", duration: 1.5)
            #expect(item.duration == 1.5)
        }

        @Test("position defaults to top")
        func positionDefault() {
            let item = ToastItem.info(title: "FYI")
            #expect(item.position == .top)
        }

        @Test("explicit position is stored")
        func explicitPosition() {
            let item = ToastItem.info(title: "FYI", position: .bottom)
            #expect(item.position == .bottom)
        }

        @Test("haptic defaults to nil")
        func hapticDefaultsToNil() {
            let item = ToastItem.info(title: "FYI")
            #expect(item.haptic == nil)
        }
    }

    // MARK: Equatable

    @Suite("Equatable conformance")
    struct EquatableTests {

        @Test("same instance is equal to itself")
        func reflexive() {
            let item = ToastItem(style: .success, title: "Done")
            #expect(item == item)
        }

        @Test("two items with the same id are equal")
        func equalByID() {
            // Equality is driven by id (UUID); we cannot create two items sharing
            // a UUID via the public API, so we verify a copy of the same item equals itself.
            let item = ToastItem(style: .success, title: "Done")
            let copy = item  // value-type copy shares the same UUID
            #expect(item == copy)
        }

        @Test("two separately constructed items with identical content are not equal")
        func differentInstancesNotEqual() {
            // Each init mints a new UUID, so even identical content yields inequality.
            let a = ToastItem(style: .success, title: "Done")
            let b = ToastItem(style: .success, title: "Done")
            #expect(a != b)
        }

        @Test("factory items with same arguments are not equal")
        func factoryItemsNotEqual() {
            let a = ToastItem.error(title: "Failed")
            let b = ToastItem.error(title: "Failed")
            #expect(a != b)
        }
    }

    // MARK: Sendable

    @Test("ToastItem can be sent across concurrency boundaries")
    func sendable() async {
        let item = ToastItem(style: .success, title: "Async Toast")
        let title = await Task { item.title }.value
        #expect(title == "Async Toast")
    }

    // MARK: Edge cases

    @Suite("Edge cases")
    struct EdgeCaseTests {

        @Test("empty title string is stored as-is")
        func emptyTitle() {
            let item = ToastItem(style: .info, title: "")
            #expect(item.title == "")
        }

        @Test("zero duration is stored")
        func zeroDuration() {
            let item = ToastItem(style: .info, title: "Flash", duration: 0)
            #expect(item.duration == 0)
        }

        @Test("very large duration is stored")
        func largeDuration() {
            let item = ToastItem(style: .info, title: "Persist", duration: .infinity)
            #expect(item.duration == .infinity)
        }

        @Test("unicode title is stored correctly")
        func unicodeTitle() {
            let title = "Saved \u{2705} 成功"
            let item = ToastItem(style: .success, title: title)
            #expect(item.title == title)
        }

        @Test("unicode subtitle is stored correctly")
        func unicodeSubtitle() {
            let subtitle = "詳細 \u{1F4AC}"
            let item = ToastItem(style: .info, title: "Info", subtitle: subtitle)
            #expect(item.subtitle == subtitle)
        }

        @Test("custom style fields survive round-trip through ToastItem")
        func customStyleRoundTrip() {
            let style = ToastStyle.custom(systemIcon: "moon.stars.fill", tint: .indigo)
            let item = ToastItem(style: style, title: "Night Mode")
            #expect(item.style == style)
            #expect(item.style.iconName == "moon.stars.fill")
            #expect(item.style.tintColor == .indigo)
        }
    }
}
