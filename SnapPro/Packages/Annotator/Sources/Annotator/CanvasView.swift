import SwiftUI
import SnapProCore

public struct EditorView: View {
    public let baseImage: NSImage
    @State private var shapes: [AnyShape] = []
    @State private var selectedTool: Tool = .rectangle

    public init(baseImage: NSImage) {
        self.baseImage = baseImage
    }

    public var body: some View {
        VStack(spacing: 0) {
            ToolboxView(selectedTool: $selectedTool)
            Canvas { context, size in
                if let cg = baseImage.cgImage() {
                    context.draw(Image(decorative: cg, scale: 1, orientation: .up), at: .zero, anchor: .topLeading)
                }
                for shape in shapes {
                    context.drawLayer { layerContext in
                        shape.draw(in: &layerContext)
                    }
                }
            }
            .frame(minWidth: 640, minHeight: 400)
            .gesture(DragGesture(minimumDistance: 0).onEnded { value in
                addShape(at: value.location)
            })
        }
    }

    private func addShape(at point: CGPoint) {
        let frame = CGRect(origin: CGPoint(x: max(point.x - 60, 0), y: max(point.y - 40, 0)),
                           size: CGSize(width: 120, height: 80))
        switch selectedTool {
        case .rectangle:
            shapes.append(AnyShape(RectShape(frame: frame)))
        case .arrow:
            shapes.append(AnyShape(ArrowShape(frame: frame)))
        case .text:
            shapes.append(AnyShape(TextShape(frame: frame, text: "文本")))
        case .blur:
            shapes.append(AnyShape(BlurShape(frame: frame)))
        }
    }
}

struct AnyShape: ShapeModel {
    private var frameGetter: () -> CGRect
    private var frameSetter: (CGRect) -> Void
    private var drawer: (inout GraphicsContext) -> Void
    public let id: UUID

    init<S: ShapeModel>(_ shape: S) {
        var mutableShape = shape
        id = shape.id
        frameGetter = { mutableShape.frame }
        frameSetter = { mutableShape.frame = $0 }
        drawer = { context in mutableShape.draw(in: &context) }
    }

    var frame: CGRect {
        get { frameGetter() }
        set { frameSetter(newValue) }
    }

    func draw(in context: inout GraphicsContext) {
        drawer(&context)
    }
}

public enum Tool: CaseIterable {
    case rectangle
    case arrow
    case text
    case blur
}
