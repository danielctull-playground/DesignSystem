import DesignSystem
import SwiftUI

extension RowStyle where Self == CustomRowStyle {
    static var custom: Self { Self() }
}

struct CustomRowStyle: RowStyle {

    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .primary) {
            configuration.leading
            configuration.content
            Spacer()
            configuration.trailing
        }
        .detailStyle(RowDetailStyle())
    }
}

private struct RowDetailStyle: DetailStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.primary
                .alignmentGuide(.primary) { $0[VerticalAlignment.center] }
            configuration.secondary
                .alignmentGuide(.secondary) { $0[VerticalAlignment.center] }
            configuration.tertiary
                .alignmentGuide(.tertiary) { $0[VerticalAlignment.center] }
        }
    }
}

extension VerticalAlignment {

    static let primary = VerticalAlignment(Primary.self)
    static let secondary = VerticalAlignment(Secondary.self)
    static let tertiary = VerticalAlignment(Tertiary.self)


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
