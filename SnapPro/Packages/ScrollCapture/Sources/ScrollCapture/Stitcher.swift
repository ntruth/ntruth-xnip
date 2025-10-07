import AppKit

public final class Stitcher {
    public init() {}

    public func stitch(segments: [CaptureSegment]) -> NSImage? {
        guard !segments.isEmpty else { return nil }
        let totalHeight = segments.reduce(CGFloat.zero) { $0 + $1.image.size.height }
        let width = segments.first?.image.size.width ?? 0
        let size = CGSize(width: width, height: totalHeight)
        let image = NSImage(size: size)
        image.lockFocus()
        var y: CGFloat = totalHeight
        for segment in segments {
            y -= segment.image.size.height
            segment.image.draw(at: NSPoint(x: 0, y: y), from: .zero, operation: .copy, fraction: 1.0)
        }
        image.unlockFocus()
        return image
    }
}
