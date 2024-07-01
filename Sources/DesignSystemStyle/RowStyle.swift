import DesignSystem
import SwiftUI

extension RowStyle where Self == CustomRowStyle {
    public static var custom: Self { Self() }
}

public struct CustomRowStyle: RowStyle {

    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .primary, spacing: 8) {
            configuration.leading
            configuration.content
                .font(.headline)
            Spacer()
            configuration.trailing
        }
        .padding(8)
        .detailStyle(RowDetailStyle())
    }
}

private struct RowDetailStyle: DetailStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            configuration.primary
                .font(.headline)
            configuration.secondary
                .font(.subheadline)
            configuration.tertiary
                .font(.caption)
        }
    }
}

#Preview("RowStyle") {
    List {
        Row {
            Text("Title")
        }

        Row {
            Text("Title")
        } leading: {
            Image(systemName: "info.circle")
        }

        Row {
            Text("Title")
        } trailing: {
            Image(systemName: "chevron.right")
        }

        Row {
            Text("Title")
        } leading: {
            Image(systemName: "info.circle")
        } trailing: {
            Image(systemName: "chevron.right")
        }

        Row {
            Text("Title")
        } secondary: {
            Text("Subtitle")
        }

        Row {
            Text("Title")
        } secondary: {
            Text("Subtitle")
        } leading: {
            Image(systemName: "info.circle")
        }

        Row {
            Text("Title")
        } secondary: {
            Text("Subtitle")
        } trailing: {
            Image(systemName: "chevron.right")
        }

        Row {
            Text("Title")
        } secondary: {
            Text("Subtitle")
        } leading: {
            Image(systemName: "info.circle")
        } trailing: {
            Image(systemName: "chevron.right")
        }
    }
    .frame(width: 320, height: 500)
    .rowStyle(.custom)
}
