import DesignSystem
import SwiftUI

extension ButtonStyle where Self == StandardButtonStyle {
  public static var standard: Self { Self() }
}

public struct StandardButtonStyle: ButtonStyle {

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .bold()
      .background(.action)
      .cornerRadius(8)
      .foregroundStyle(.white)
  }
}

#Preview("ButtonStyle") {
  VStack(spacing: 10) {

    Button("Red Button") {}
      .actionStyle(.red)

    Button("Blue Button") {}
      .actionStyle(.blue)
  }
  .buttonStyle(.standard)
  .frame(width: 400, height: 500)
}
