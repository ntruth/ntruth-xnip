import AppKit
import Integration
import CaptureKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    private let hotkeyManager = HotkeyManager()
    private let screenPermission = ScreenRecordingPermission()

    func applicationDidFinishLaunching(_ notification: Notification) {
        screenPermission.ensureAuthorizedIfNeeded()
        CaptureService.shared.onCapture = { image in
            EditorWindow.present(with: image)
        }
        hotkeyManager.registerDefaults()
    }
}
