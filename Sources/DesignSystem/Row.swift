import SwiftUI

public struct Row<Content: View, Leading: View, Trailing: View>: View {

    @Environment(\.rowStyle) private var style

    private let content: Content
    private let leading: Leading
    private let trailing: Trailing

    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.content = content()
        self.leading = leading()
        self.trailing = trailing()
    }

    public var body: some View {
        let configuration = RowStyleConfiguration(
            content: content,
            leading: leading,
            trailing: trailing)
        AnyView(style.resolve(configuration: configuration))
    }
}

extension Row {

    public init<Primary, Secondary>(
        @ViewBuilder primary: () -> Primary,
        @ViewBuilder secondary: () -> Secondary,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) where Content == Detail<Primary, Secondary, EmptyView> {
        self.init {
            Detail {
                primary()
            } secondary: {
                secondary()
            }
        } leading: {
            leading()
        } trailing: {
            trailing()
        }
    }
}

// MARK: - Style

public protocol RowStyle: DynamicProperty {

    typealias Configuration = RowStyleConfiguration
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

private struct DefaultRowStyle: RowStyle {

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.leading
            configuration.content
            Spacer()
            configuration.trailing
        }
    }
}

// MARK: - Environment

private enum RowStyleKey: EnvironmentKey {
    static let defaultValue: any RowStyle = DefaultRowStyle()
}

extension EnvironmentValues {

    fileprivate var rowStyle: any RowStyle {
        get { self[RowStyleKey.self] }
        set { self[RowStyleKey.self] = newValue }
    }
}

extension View {

    public func rowStyle(_ style: some RowStyle) -> some View {
        environment(\.rowStyle, style)
    }
}

extension Scene {

    public func rowStyle(_ style: some RowStyle) -> some Scene {
        environment(\.rowStyle, style)
    }
}

// MARK: - Configuration

public struct RowStyleConfiguration {

    public struct Content: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Leading: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Trailing: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let content: Content
    public let leading: Leading
    public let trailing: Trailing

    fileprivate init(
        content: some View,
        leading: some View,
        trailing: some View
    ) {
        self.content = Content(base: AnyView(content))
        self.leading = Leading(base: AnyView(leading))
        self.trailing = Trailing(base: AnyView(trailing))
    }
}

// MARK: - Resolution

extension RowStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedRowStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedRowStyle<Style: RowStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
