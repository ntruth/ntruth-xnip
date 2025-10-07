import CoreGraphics

public struct PixelGrid {
    public var size: CGSize
    public var spacing: CGFloat

    public init(size: CGSize, spacing: CGFloat = 1) {
        self.size = size
        self.spacing = spacing
    }

    public func lines() -> [CGRect] {
        var rects: [CGRect] = []
        guard spacing > 0 else { return rects }
        var x: CGFloat = 0
        while x <= size.width {
            rects.append(CGRect(x: x, y: 0, width: 0.5, height: size.height))
            x += spacing
        }
        var y: CGFloat = 0
        while y <= size.height {
            rects.append(CGRect(x: 0, y: y, width: size.width, height: 0.5))
            y += spacing
        }
        return rects
    }
}
