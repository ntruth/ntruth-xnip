import SwiftUI

public struct TextShape: ShapeModel {
    public let id: UUID
    public var frame: CGRect
    public var text: String
    public var color: Color
    public var fontSize: CGFloat

    public init(frame: CGRect, text: String, color: Color = .white, fontSize: CGFloat = 16) {
        self.id = UUID()
        self.frame = frame
        self.text = text
        self.color = color
        self.fontSize = fontSize
    }

    public func draw(in context: inout GraphicsContext) {
        let nsColor = NSColor(color)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: fontSize, weight: .medium),
            .foregroundColor: nsColor
        ]
        let attributed = NSAttributedString(string: text, attributes: attributes)
        context.draw(Text(attributed), in: frame)
    }
}
