import AppKit

public final class MenuBarController {
    private var statusItem: NSStatusItem?

    public init() {}

    public func setup() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        statusItem?.button?.image = NSImage(systemSymbolName: "camera.fill", accessibilityDescription: "SnapPro")
        statusItem?.button?.toolTip = "SnapPro"
    }
}
