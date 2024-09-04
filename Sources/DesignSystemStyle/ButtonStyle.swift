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
      .background(.action.background)
      .cornerRadius(8)
      .foregroundStyle(.action)
  }
}

extension Action {
  static let red = Action(foreground: .white, background: .red)
  static let blue = Action(foreground: .white, background: .blue)
  static let inverse = Action(foreground: .blue, background: .white)
}

#Preview("ButtonStyle") {
  VStack(spacing: 10) {

    Button("Red Button") {}
      .actionStyle(.red)

    Button("Blue Button") {}
      .actionStyle(.blue)

    Button("Inverse Button") {}
      .actionStyle(.inverse)
  }
  .buttonStyle(.standard)
  .frame(width: 400, height: 500)
}
