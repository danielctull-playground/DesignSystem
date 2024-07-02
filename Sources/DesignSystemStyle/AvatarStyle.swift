import DesignSystem
import SwiftUI

extension AvatarStyle where Self == StandardAvatarStyle {
    public static var standard: Self { Self() }
}

public struct StandardAvatarStyle: AvatarStyle {

    public func makeBody(configuration: Configuration) -> some View {

        ZStack {
            Circle()
                .foregroundColor(.black)

            Circle()
                .inset(by: 8)
                .foregroundColor(.orange)

            configuration.content
                .foregroundColor(.black)
                .textCase(.uppercase)
                .font(.system(size: 50))
        }
        .frame(width: 100, height: 100)
    }
}

#Preview("AvatarStyle") {
    HStack(spacing: 25) {
        Avatar()
        Avatar(initials: "DT")
        Avatar(image: Image(systemName: "photo.circle.fill"))
    }
    .frame(width: 400, height: 200)
    .avatarStyle(.standard)
}
