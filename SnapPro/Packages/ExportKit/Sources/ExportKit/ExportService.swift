import AppKit
import SwiftUI
import Annotator
import SnapProCore

public enum ExportFormat {
    case png
    case jpeg(quality: CGFloat)
    case pdf
}

public final class ExportService {
    public init() {}

    public func export(baseImage: NSImage, shapes: [any ShapeModel], to url: URL, format: ExportFormat) throws {
        switch format {
        case .png:
            try exportPNG(baseImage: baseImage, shapes: shapes, to: url)
        case .jpeg(let quality):
            try exportJPEG(baseImage: baseImage, shapes: shapes, to: url, quality: quality)
        case .pdf:
            try exportPDF(baseImage: baseImage, shapes: shapes, to: url)
        }
    }

    private func renderComposite(baseImage: NSImage, shapes: [any ShapeModel]) -> NSImage? {
        let renderer = ImageRenderer(content: AnnotatedCanvas(baseImage: baseImage, shapes: shapes))
        renderer.proposedSize = .init(width: baseImage.size.width, height: baseImage.size.height)
        renderer.scale = NSScreen.main?.backingScaleFactor ?? 2
        return renderer.nsImage

    }

    private func exportPNG(baseImage: NSImage, shapes: [any ShapeModel], to url: URL) throws {
        guard let combined = renderComposite(baseImage: baseImage, shapes: shapes),
              let data = combined.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: data),
              let pngData = bitmap.representation(using: .png, properties: [:]) else {
            throw ExportError.renderFailed
        }
        try pngData.write(to: url)
    }

    private func exportJPEG(baseImage: NSImage, shapes: [any ShapeModel], to url: URL, quality: CGFloat) throws {
        guard let combined = renderComposite(baseImage: baseImage, shapes: shapes),
              let data = combined.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: data),
              let jpegData = bitmap.representation(using: .jpeg, properties: [.compressionFactor: quality]) else {
            throw ExportError.renderFailed
        }
        try jpegData.write(to: url)
    }

    private func exportPDF(baseImage: NSImage, shapes: [any ShapeModel], to url: URL) throws {
        guard let combined = renderComposite(baseImage: baseImage, shapes: shapes),
              let pdfData = combined.dataWithPDF(inside: CGRect(origin: .zero, size: combined.size)) else {
            throw ExportError.renderFailed
        }
        try pdfData.write(to: url, options: .atomic)

    }
}

public enum ExportError: Error {
    case renderFailed
}

private struct AnnotatedCanvas: View {
    let baseImage: NSImage
    let shapes: [any ShapeModel]

    var body: some View {
        Canvas { context, _ in
            if let cgImage = baseImage.cgImage() {
                context.draw(Image(decorative: cgImage, scale: 1, orientation: .up), at: .zero, anchor: .topLeading)
            }
            for shape in shapes {
                var shapeContext = context
                shape.draw(in: &shapeContext)
            }
        }
        .frame(width: baseImage.size.width, height: baseImage.size.height, alignment: .topLeading)
    }
}

