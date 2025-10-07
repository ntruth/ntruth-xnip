import AppKit
import ApplicationServices

public final class ScrollController {
    public init() {}

    public func captureFullContent(of view: AXUIElement, on screen: NSScreen, completion: @escaping (NSImage?) -> Void) {
        // Stub implementation: future work to drive accessibility scroll and capture segments.
        completion(nil)
    }
}
