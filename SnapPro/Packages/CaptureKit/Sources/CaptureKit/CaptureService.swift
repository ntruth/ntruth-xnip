import AppKit

public final class CaptureService {
    public static let shared = CaptureService()

    public var onCapture: ((NSImage) -> Void)?

    private init() {}

    public func captureRegion() {
        RegionSelectionOverlay.present { [weak self] image in
            self?.onCapture?(image)
        }
    }

    public func captureWindow() {
        WindowPicker.pick { [weak self] image in
            guard let image else { return }
            self?.onCapture?(image)
        }
    }

    public func captureScreen() {
        guard let screen = NSScreen.main else { return }
        let rect = screen.frame
        guard let cgImage = CGWindowListCreateImage(rect, .optionOnScreenOnly, kCGNullWindowID, [.bestResolution]) else {
            return
        }
        onCapture?(NSImage(cgImage: cgImage, size: rect.size))
    }
}
