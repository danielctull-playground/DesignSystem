import SwiftUI

//struct ColorSet {
//  let primary: (EnvironmentValues) -> AnyShapeStyle
//  let secondary: (EnvironmentValues) -> AnyShapeStyle
//  let tertiary: (EnvironmentValues) -> AnyShapeStyle
//}


public struct Theme {
  let main: AnyShapeStyle

  init(main: some ShapeStyle) {
    self.main = AnyShapeStyle(main)
  }
}

extension View {

  public func theme(_ theme: Theme) -> some View {
    mainColor(theme.main)
  }
}




public struct MainColor: ShapeStyle {
  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    switch environment.colorScheme {
    case .light:
      environment.mainColor
    case .dark:
      environment.mainColor
    }
  }
}

extension ShapeStyle where Self == MainColor {
  public static var main: Self { Self() }
}

extension View {
  public func mainColor(_ color: some ShapeStyle) -> some View {
    environment(\.mainColor, AnyShapeStyle(color))
  }
}

extension EnvironmentValues {
  @Entry fileprivate var mainColor: AnyShapeStyle = AnyShapeStyle(.black)
}
//
//extension ColorSet: ShapeStyle {
//
//  func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
//    environment.backgroundStyle!
//  }
//}
//
//extension View {
//
//  func colors(colors: ColorSet) -> some View {
//    self.foregroundStyle(colors.primary, colors.secondary, colors.tertiary)
//  }
//}
