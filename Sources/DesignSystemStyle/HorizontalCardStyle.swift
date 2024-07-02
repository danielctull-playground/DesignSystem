import DesignSystem
import SwiftUI

extension CardStyle where Self == HorizontalCardStyle {
    public static var horizontal: Self { Self() }
}

public struct HorizontalCardStyle: CardStyle {

    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top, spacing: 0) {

            configuration.media

            VStack(spacing: 8) {

                configuration.accessory
                    .horizontallyStack(spacing: 4)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                configuration.title
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(.yellow)

                configuration.content
                    .font(.callout)
                    .background(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .roundedBorder(.gray, cornerRadius: 8)
    }
}

extension View {

    @ViewBuilder
    fileprivate func horizontallyStack(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil
    ) -> some View {
        if self is EmptyView {
            self
        } else {
            HStack(alignment: alignment, spacing: spacing) {
                self
            }
        }
    }

    fileprivate func roundedBorder(
        _ content: some ShapeStyle,
        lineWidth: CGFloat = 1,
        cornerRadius: CGFloat
    ) -> some View {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: lineWidth))
     }
 }

#Preview("Horizontal CardStyle") {
    Grid {
        GridRow {

            Card {
                Text("This is a really long piece of content.")
                Text("Content 2")
                Text("Content 3")
            }

            Card {
                Text("This is a really long piece of content.")
                Text("Content 2")
                Text("Content 3")
            } title: {
                Text("Title")
            }
        }

        GridRow {
            Card {
                Text("This is a really long piece of content.")
                Text("Content 2")
                Text("Content 3")
            } media: {
                Color.orange
                    .aspectRatio(3/2, contentMode: .fit)
                    .overlay {
                        Image(systemName: "photo")
                            .imageScale(.large)
                    }
            }

            Card {
                Text("This is a really long piece of content.")
                Text("Content 2")
                Text("Content 3")
            } media: {
                Color.orange
                    .aspectRatio(3/2, contentMode: .fit)
                    .overlay {
                        Image(systemName: "photo")
                            .imageScale(.large)
                    }
            } accessory: {
                Color.red
                    .frame(width: 30, height: 20)
                Color.yellow
                    .frame(width: 30, height: 20)
                Color.blue
                    .frame(width: 30, height: 20)
            }
        }

        GridRow {
            Card {
                Text("This is a really long piece of content.")
                Text("Content 2")
                Text("Content 3")
            } title: {
                Text("Title")
            } media: {
                Color.orange
                    .aspectRatio(3/2, contentMode: .fit)
                    .overlay {
                        Image(systemName: "photo")
                            .imageScale(.large)
                    }
            }

            Card {
                Text("This is a really long piece of content.")
                Text("Content 2")
                Text("Content 3")
            } title: {
                Text("Title")
            } media: {
                Color.orange
                    .aspectRatio(3/2, contentMode: .fit)
                    .overlay {
                        Image(systemName: "photo")
                            .imageScale(.large)
                    }
            } accessory: {
                Color.red
                    .frame(width: 30, height: 20)
                Color.yellow
                    .frame(width: 30, height: 20)
                Color.blue
                    .frame(width: 30, height: 20)
            }
        }
    }
    .padding()
    .frame(width: 600, height: 700)
    .cardStyle(.horizontal)
}
