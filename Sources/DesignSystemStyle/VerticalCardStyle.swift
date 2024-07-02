import DesignSystem
import SwiftUI

extension CardStyle where Self == VerticalCardStyle {
    public static var vertical: Self { Self() }
}

public struct VerticalCardStyle: CardStyle {

    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 8) {

            configuration.title
                .font(.headline)
                .frame(maxWidth: .infinity)
                .background(.yellow)
                .padding(.horizontal, 8)
                .padding(.top, 8)

            configuration.media
                .overlay(alignment: .bottomLeading) {
                    HStack(spacing: 4) {
                        configuration.accessory
                    }
                    .padding(4)
                }

            configuration.content
                .font(.callout)
                .background(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
        }
        .padding(.bottom, 8)
        .frame(maxWidth: .infinity)
        .background(.white)
        .roundedBorder(.gray, cornerRadius: 8)

    }
}

extension View {
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

#Preview("Vertical CardStyle") {
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
    .frame(width: 320, height: 700)
    .cardStyle(.vertical)
}
