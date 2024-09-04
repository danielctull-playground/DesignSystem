import SwiftUI

public struct ActionStyle: ShapeStyle {
  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    environment.actionColor
  }
}

extension ShapeStyle where Self == ActionStyle {
  public static var action: Self { Self() }
}

extension View {
  public func actionStyle(_ style: some ShapeStyle) -> some View {
    environment(\.actionColor, AnyShapeStyle(style))
  }
}

extension EnvironmentValues {
  @Entry fileprivate var actionColor = AnyShapeStyle(.blue)
}
