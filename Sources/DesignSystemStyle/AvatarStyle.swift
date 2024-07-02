import DesignSystem
import SwiftUI

extension AvatarStyle where Self == StandardAvatarStyle {

    public static var small: Self { standard(size: 25, font: 12.5, inset: 2) }
    public static var medium: Self { standard(size: 50, font: 25, inset: 4) }
    public static var large: Self { standard(size: 100, font: 50, inset: 8) }

    fileprivate static func standard(size: CGFloat, font: CGFloat, inset: CGFloat) -> Self {
        StandardAvatarStyle(size: size, font: font, inset: inset)
    }
}

public struct StandardAvatarStyle: AvatarStyle {
    let size: CGFloat
    let font: CGFloat
    let inset: CGFloat

    public func makeBody(configuration: Configuration) -> some View {

        ZStack {
            Circle()
                .foregroundColor(.black)

            Circle()
                .inset(by: inset)
                .foregroundColor(.orange)

            configuration.content
                .foregroundColor(.black)
                .textCase(.uppercase)
                .font(.system(size: font))
        }
        .frame(width: size, height: size)
    }
}

#Preview("AvatarStyle") {
    VStack {
        HStack(spacing: 25) {
            Avatar()
            Avatar(initials: "DT")
            Avatar(image: Image(systemName: "photo.circle.fill"))
        }
        .avatarStyle(.small)

        HStack(spacing: 25) {
            Avatar()
            Avatar(initials: "DT")
            Avatar(image: Image(systemName: "photo.circle.fill"))
        }
        .avatarStyle(.medium)

        HStack(spacing: 25) {
            Avatar()
            Avatar(initials: "DT")
            Avatar(image: Image(systemName: "photo.circle.fill"))
        }
        .avatarStyle(.large)
    }
    .frame(width: 400, height: 500)
}
