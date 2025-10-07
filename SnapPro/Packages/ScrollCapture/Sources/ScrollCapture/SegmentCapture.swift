import AppKit
import ApplicationServices

public struct CaptureSegment {
    public var image: NSImage
    public var origin: CGPoint

    public init(image: NSImage, origin: CGPoint) {
        self.image = image
        self.origin = origin
    }
}

public final class SegmentCapture {
    public init() {}

    public func captureSegments(for view: AXUIElement) -> [CaptureSegment] {
        // Placeholder segments until implementation is provided.
        return []
    }
}
