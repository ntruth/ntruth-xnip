import SwiftUI

public struct ArrowShape: ShapeModel {
    public let id: UUID
    public var frame: CGRect
    public var color: Color
    public var lineWidth: CGFloat

    public init(frame: CGRect, color: Color = .yellow, lineWidth: CGFloat = 3) {
        self.id = UUID()
        self.frame = frame
        self.color = color
        self.lineWidth = lineWidth
    }

    public func draw(in context: inout GraphicsContext) {
        var path = Path()
        let start = CGPoint(x: frame.minX, y: frame.midY)
        let end = CGPoint(x: frame.maxX, y: frame.midY)
        path.move(to: start)
        path.addLine(to: end)

        let arrowSize: CGFloat = max(6, min(frame.width, frame.height) * 0.25)
        path.move(to: CGPoint(x: end.x - arrowSize, y: end.y + arrowSize / 2))
        path.addLine(to: end)
        path.addLine(to: CGPoint(x: end.x - arrowSize, y: end.y - arrowSize / 2))
        context.stroke(path, with: .color(color), lineWidth: lineWidth)
    }
}
