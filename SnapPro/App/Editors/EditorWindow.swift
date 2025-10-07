import SwiftUI
import AppKit
import Annotator

public enum EditorWindow {
    private static var controller: NSWindowController?

    public static func present(with image: NSImage) {
        let view = EditorView(baseImage: image)
        let hosting = NSHostingView(rootView: view)

        let window = NSWindow(contentRect: .init(x: 0, y: 0, width: 960, height: 640),
                              styleMask: [.titled, .closable, .miniaturizable, .resizable],
                              backing: .buffered,
                              defer: false)
        window.center()
        window.title = "SnapPro 编辑器"
        window.contentView = hosting

        controller = NSWindowController(window: window)
        controller?.showWindow(nil)
    }
}
