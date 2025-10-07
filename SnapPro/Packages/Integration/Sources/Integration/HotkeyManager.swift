import AppKit
import CaptureKit

public final class HotkeyManager {
    private var monitor: Any?

    public init() {}

    public func registerDefaults() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
            guard event.modifierFlags.contains([.command, .option, .shift]) else { return }
            switch event.keyCode {
            case 18: // 1
                CaptureService.shared.captureRegion()
            case 19: // 2
                CaptureService.shared.captureWindow()
            case 20: // 3
                CaptureService.shared.captureScreen()
            default:
                break
            }
        }
    }

    deinit {
        if let monitor {
            NSEvent.removeMonitor(monitor)
        }
    }
}
