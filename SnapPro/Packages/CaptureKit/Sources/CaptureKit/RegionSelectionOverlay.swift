import AppKit

public enum RegionSelectionOverlay {
    private static var activeWindows: [SelectionWindow] = []

    public static func present(on screen: NSScreen? = NSScreen.main, completion: @escaping (NSImage) -> Void) {
        guard let screen else { return }
        let overlay = SelectionWindow(screen: screen)
        overlay.onFinish = { image in
            completion(image)
            if let index = activeWindows.firstIndex(where: { $0 === overlay }) {
                activeWindows.remove(at: index)
            }
        }
        activeWindows.append(overlay)
        overlay.makeKeyAndOrderFront(nil)
        overlay.beginSelection()
    }
}

private final class SelectionWindow: NSPanel {
    fileprivate var onFinish: ((NSImage) -> Void)?
    private let selectionView = SelectionView()

    init(screen: NSScreen) {
        super.init(contentRect: screen.frame, styleMask: [.borderless], backing: .buffered, defer: true)
        level = .statusBar
        isOpaque = false
        backgroundColor = .clear
        ignoresMouseEvents = false
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        contentView = selectionView
    }

    func beginSelection() {
        makeKey()
        selectionView.onComplete = { [weak self] rect in
            guard let self else { return }
            self.orderOut(nil)
            guard rect.width > 1, rect.height > 1 else { return }
            guard let cgImage = CGWindowListCreateImage(rect, .optionOnScreenOnly, kCGNullWindowID, [.bestResolution]) else { return }
            let image = NSImage(cgImage: cgImage, size: rect.size)
            onFinish?(image)
        }
    }
}

private final class SelectionView: NSView {
    var onComplete: ((CGRect) -> Void)?
    private var startPoint: CGPoint?
    private var currentRect: CGRect = .zero {
        didSet { needsDisplay = true }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.black.withAlphaComponent(0.4).setFill()
        dirtyRect.fill()
        if currentRect != .zero {
            NSColor.clear.setFill()
            NSBezierPath(rect: currentRect).addClip()
            NSColor(calibratedWhite: 0, alpha: 0.6).setFill()
            bounds.fill()
            NSColor.systemBlue.setStroke()
            NSBezierPath(rect: currentRect).stroke()
        }
    }

    override func mouseDown(with event: NSEvent) {
        startPoint = convert(event.locationInWindow, from: nil)
        currentRect = .zero
    }

    override func mouseDragged(with event: NSEvent) {
        guard let start = startPoint else { return }
        let current = convert(event.locationInWindow, from: nil)
        currentRect = CGRect(x: min(start.x, current.x),
                             y: min(start.y, current.y),
                             width: abs(start.x - current.x),
                             height: abs(start.y - current.y))
    }

    override func mouseUp(with event: NSEvent) {
        onComplete?(currentRect)
    }
}
