import AppKit
import ApplicationServices

public enum WindowPicker {
    public static func pick(completion: @escaping (NSImage?) -> Void) {
        guard let screen = NSScreen.main else {
            completion(nil)
            return
        }
        let options: CGWindowListOption = [.optionOnScreenOnly, .excludeDesktopElements]
        guard let windowList = CGWindowListCopyWindowInfo(options, kCGNullWindowID) as? [[String: Any]] else {
            completion(nil)
            return
        }
        guard let windowInfo = windowList.first,
              let windowID = windowInfo[kCGWindowNumber as String] as? CGWindowID else {
            completion(nil)
            return
        }
        let bounds = CGRect(origin: .zero, size: screen.frame.size)
        let image = CGWindowListCreateImage(bounds, options, windowID, [.bestResolution])
        if let image {
            completion(NSImage(cgImage: image, size: bounds.size))
        } else {
            completion(nil)
        }
    }
}
