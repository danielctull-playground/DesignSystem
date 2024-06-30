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
                .font(.headline)
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
                .font(.headline)
            configuration.secondary
                .font(.subheadline)
            configuration.tertiary
                .font(.caption)
        }
    }
}
