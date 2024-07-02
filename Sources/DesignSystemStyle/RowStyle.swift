import DesignSystem
import SwiftUI

extension RowStyle where Self == CustomRowStyle {
    public static var custom: Self { Self() }
}

public struct CustomRowStyle: RowStyle {

    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .primary, spacing: 8) {
            configuration.leading
                .background(.purple)
            configuration.content
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.orange)
            configuration.trailing
                .background(.pink)
        }
//        .padding(.vertical, 8)
        .detailStyle(RowDetailStyle())
        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .listRowBackground(Color.gray)
    }
}

private struct RowDetailStyle: DetailStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            configuration.primary
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.yellow)
            configuration.secondary
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.blue)
            configuration.tertiary
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.red)
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

        Row {
            Detail {
                Text("Title")
            } secondary: {
                Text("Subtitle")
            } tertiary: {
                Text("More 1")
                Text("More 2")
            }
        } leading: {
            Image(systemName: "info.circle")
        } trailing: {
            Image(systemName: "chevron.right")
        }
    }
    .frame(width: 320, height: 500)
    .rowStyle(.custom)
}
