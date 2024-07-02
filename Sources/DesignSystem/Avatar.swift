import SwiftUI

public struct Avatar: View {

    @Environment(\.avatarStyle) private var style
    private let content: Content

    public var body: some View {
        let configuration = AvatarStyleConfiguration(content: content)
        AnyView(style.resolve(configuration: configuration))
    }
}

extension Avatar {

    public init() {
        self.init(content: .blank)
    }

    public init(image: Image) {
        self.init(content: .image(image))
    }

    public init(initials: some StringProtocol) {
        self.init(content: .initials(String(initials)))
    }
}

extension Avatar {
    private enum Content: View {
        case blank
        case image(Image)
        case initials(String)

        var body: some View {
            Group {
                switch self {
                case .blank:
                    Image(systemName: "person.crop.circle")
                        .resizable()
                case .image(let image):
                    image.resizable()
                case .initials(let string):
                    Text(string)
                }
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
}

// MARK: - Style

public protocol AvatarStyle: DynamicProperty {

    typealias Configuration = AvatarStyleConfiguration
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

private struct DefaultAvatarStyle: AvatarStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .mask { Circle() }
    }
}

// MARK: - Environment

private enum AvatarStyleKey: EnvironmentKey {
    static let defaultValue: any AvatarStyle = DefaultAvatarStyle()
}

extension EnvironmentValues {

    fileprivate var avatarStyle: any AvatarStyle {
        get { self[AvatarStyleKey.self] }
        set { self[AvatarStyleKey.self] = newValue }
    }
}

extension View {

    public func avatarStyle(_ style: some AvatarStyle) -> some View {
        environment(\.avatarStyle, style)
    }
}

extension Scene {

    public func avatarStyle(_ style: some AvatarStyle) -> some Scene {
        environment(\.avatarStyle, style)
    }
}

// MARK: - Configuration

public struct AvatarStyleConfiguration {

    public struct Content: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let content: Content

    fileprivate init(
        content: some View
    ) {
        self.content = Content(base: AnyView(content))
    }
}

// MARK: - Resolution

extension AvatarStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedAvatarStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedAvatarStyle<Style: AvatarStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
