import SwiftUI

public struct Action {
  let foreground: AnyShapeStyle
  let background: AnyShapeStyle

  public init(
    foreground: some ShapeStyle,
    background: some ShapeStyle
  ) {
    self.foreground = AnyShapeStyle(foreground)
    self.background = AnyShapeStyle(background)
  }
}

public struct ActionStyle: ShapeStyle {
  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    environment.action.foreground
  }
}

extension ShapeStyle where Self == ActionStyle {
  public static var action: Self { Self() }
}

extension ActionStyle {
  public var background: some ShapeStyle { KeyedShapeStyle(keyPath: \.action.background) }
}

extension View {
  public func actionStyle(_ style: Action) -> some View {
    environment(\.action, style)
  }
}

extension EnvironmentValues {
  @Entry fileprivate var action = Action(
    foreground: .foreground,
    background: .background
  )
}

public struct KeyedShapeStyle<Style: ShapeStyle>: ShapeStyle {
  let keyPath: KeyPath<EnvironmentValues, Style>
  public func resolve(in environment: EnvironmentValues) -> Style {
    environment[keyPath: keyPath]
  }
}
