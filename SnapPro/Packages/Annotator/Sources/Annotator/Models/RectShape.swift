import SwiftUI

public struct RectShape: ShapeModel {
    public let id: UUID
    public var frame: CGRect
    public var color: Color
    public var lineWidth: CGFloat

    public init(frame: CGRect, color: Color = .red, lineWidth: CGFloat = 2) {
        self.id = UUID()
        self.frame = frame
        self.color = color
        self.lineWidth = lineWidth
    }

    public func draw(in context: inout GraphicsContext) {
        let path = Path(frame)
        context.stroke(path, with: .color(color), lineWidth: lineWidth)
    }
}
