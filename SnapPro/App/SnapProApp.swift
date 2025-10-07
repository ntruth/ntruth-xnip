import SwiftUI
import SnapProCore
import Integration

@main
struct SnapProApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var environment = AppEnvironment.live

    var body: some Scene {
        MenuBarExtra("SnapPro", systemImage: "camera") {
            ContentView()
                .environmentObject(environment)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
                .environmentObject(environment)
        }
    }
}
