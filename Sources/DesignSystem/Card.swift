import SwiftUI

public struct Card<Content: View, Title: View, Media: View, Accessory: View>: View {

    @Environment(\.cardStyle) private var style

    private let content: Content
    private let title: Title
    private let media: Media
    private let accessory: Accessory

    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder title: () -> Title,
        @ViewBuilder media: () -> Media,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.content = content()
        self.title = title()
        self.media = media()
        self.accessory = accessory()
    }

    public var body: some View {
        let configuration = CardStyleConfiguration(
            content: content,
            title: title,
            media: media,
            accessory: accessory)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - Style

public protocol CardStyle: DynamicProperty {

    typealias Configuration = CardStyleConfiguration
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

private struct DefaultCardStyle: CardStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.title
            configuration.media
                .overlay(alignment: .bottomLeading) {
                    configuration.accessory
                }
            configuration.content
        }
    }
}

// MARK: - Environment

private enum CardStyleKey: EnvironmentKey {
    static let defaultValue: any CardStyle = DefaultCardStyle()
}

extension EnvironmentValues {

    fileprivate var cardStyle: any CardStyle {
        get { self[CardStyleKey.self] }
        set { self[CardStyleKey.self] = newValue }
    }
}

extension View {

    public func cardStyle(_ style: some CardStyle) -> some View {
        environment(\.cardStyle, style)
    }
}

extension Scene {

    public func cardStyle(_ style: some CardStyle) -> some Scene {
        environment(\.cardStyle, style)
    }
}

// MARK: - Configuration

public struct CardStyleConfiguration {

    public struct Content: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Title: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Media: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Accessory: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let content: Content
    public let title: Title
    public let media: Media
    public let accessory: Accessory

    fileprivate init(
        content: some View,
        title: some View,
        media: some View,
        accessory: some View
    ) {
        self.content = Content(base: AnyView(content))
        self.title = Title(base: AnyView(title))
        self.media = Media(base: AnyView(media))
        self.accessory = Accessory(base: AnyView(accessory))
    }
}

// MARK: - Resolution

extension CardStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedCardStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedCardStyle<Style: CardStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
