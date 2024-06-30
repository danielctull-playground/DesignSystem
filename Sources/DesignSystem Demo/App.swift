import DesignSystem
import SwiftUI

@main
struct Demo: App {

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Components()
            }
        }
    }
}


struct Components: View {
    var body: some View {
        List {
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
            } leading: {
                Image(systemName: "info.circle")
            } trailing: {
                Image(systemName: "chevron.right")
            }
        }
    }
}
