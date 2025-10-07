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
        let size = baseImage.size
        let image = NSImage(size: size)
        image.lockFocus()
        baseImage.draw(in: NSRect(origin: .zero, size: size))
        if let context = NSGraphicsContext.current?.cgContext {
            var graphicsContext = GraphicsContext(context, flipped: false)
            for shape in shapes {
                var shapeContext = graphicsContext
                shape.draw(in: &shapeContext)
            }
        }
        image.unlockFocus()
        return image
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
        let data = NSMutableData()
        guard let consumer = CGDataConsumer(data: data as CFMutableData) else {
            throw ExportError.renderFailed
        }
        var mediaBox = CGRect(origin: .zero, size: baseImage.size)
        guard let pdfContext = CGContext(consumer: consumer, mediaBox: &mediaBox, nil) else {
            throw ExportError.renderFailed
        }
        pdfContext.beginPDFPage(nil)
        if let cg = baseImage.cgImage() {
            pdfContext.draw(cg, in: mediaBox)
        }
        var graphics = GraphicsContext(pdfContext, flipped: false)
        for shape in shapes {
            var shapeContext = graphics
            shape.draw(in: &shapeContext)
        }
        pdfContext.endPDFPage()
        pdfContext.closePDF()
        try data.write(to: url, options: .atomic)
    }
}

public enum ExportError: Error {
    case renderFailed
}
