import SwiftUI

public struct BlurShape: ShapeModel {
    public let id: UUID
    public var frame: CGRect
    public var radius: CGFloat

    public init(frame: CGRect, radius: CGFloat = 8) {
        self.id = UUID()
        self.frame = frame
        self.radius = radius
    }

    public func draw(in context: inout GraphicsContext) {
        let path = Path(frame)
        context.addFilter(.blur(radius: radius))
        context.fill(path, with: .color(.black.opacity(0.5)))
    }
}
