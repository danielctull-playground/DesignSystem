import SwiftUI

public struct Detail<Primary: View, Secondary: View, Tertiary: View>: View {

    @Environment(\.detailStyle) private var style

    private let primary: Primary
    private let secondary: Secondary
    private let tertiary: Tertiary

    public init(
        @ViewBuilder primary: () -> Primary,
        @ViewBuilder secondary: () -> Secondary,
        @ViewBuilder tertiary: () -> Tertiary
    ) {
        self.primary = primary()
        self.secondary = secondary()
        self.tertiary = tertiary()
    }

    public var body: some View {
        let configuration = DetailStyleConfiguration {
            primary
                .alignmentGuide(.primary) { $0[VerticalAlignment.center] }
        } secondary: {
            secondary
                .alignmentGuide(.secondary) { $0[VerticalAlignment.center] }
        } tertiary: {
            tertiary
                .alignmentGuide(.tertiary) { $0[VerticalAlignment.center] }
        }
        AnyView(style.resolve(configuration: configuration))
    }
}

extension Detail {

    public init(
        @ViewBuilder primary: () -> Primary,
        @ViewBuilder secondary: () -> Secondary
    ) where Tertiary == EmptyView {
        self.init(
            primary: primary,
            secondary: secondary,
            tertiary: EmptyView.init)
    }
}

// MARK: - Alignment Guides

extension VerticalAlignment {
    
    /// Vertical alignment guide for the primary content of a ``Detail`` view.
    public static let primary = VerticalAlignment(Primary.self)

    /// Vertical alignment guide for the secondary content of a ``Detail`` view.
    public static let secondary = VerticalAlignment(Secondary.self)

    /// Vertical alignment guide for the tertiary content of a ``Detail`` view.
    public static let tertiary = VerticalAlignment(Tertiary.self)

    private struct Primary: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }

    private struct Secondary: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }

    private struct Tertiary: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
}

// MARK: - Style

public protocol DetailStyle: DynamicProperty {

    typealias Configuration = DetailStyleConfiguration
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

private struct DefaultDetailStyle: DetailStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.primary
            configuration.secondary
            configuration.tertiary
        }
    }
}

// MARK: - Environment

private enum DetailStyleKey: EnvironmentKey {
    static let defaultValue: any DetailStyle = DefaultDetailStyle()
}

extension EnvironmentValues {

    fileprivate var detailStyle: any DetailStyle {
        get { self[DetailStyleKey.self] }
        set { self[DetailStyleKey.self] = newValue }
    }
}

extension View {

    public func detailStyle(_ style: some DetailStyle) -> some View {
        environment(\.detailStyle, style)
    }
}

extension Scene {

    public func detailStyle(_ style: some DetailStyle) -> some Scene {
        environment(\.detailStyle, style)
    }
}

// MARK: - Configuration

public struct DetailStyleConfiguration {

    public struct Primary: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }
    
    public struct Secondary: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }
    
    public struct Tertiary: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let primary: Primary
    public let secondary: Secondary
    public let tertiary: Tertiary

    fileprivate init(
        @ViewBuilder primary: () -> some View,
        @ViewBuilder secondary: () -> some View,
        @ViewBuilder tertiary: () -> some View
    ) {
        self.primary = Primary(base: AnyView(primary()))
        self.secondary = Secondary(base: AnyView(secondary()))
        self.tertiary = Tertiary(base: AnyView(tertiary()))
    }
}

// MARK: - Resolution

extension DetailStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedDetailStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedDetailStyle<Style: DetailStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
