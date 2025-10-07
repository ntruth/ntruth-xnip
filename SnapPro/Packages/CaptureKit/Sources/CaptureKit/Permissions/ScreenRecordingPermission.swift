import AppKit
import ApplicationServices

public final class ScreenRecordingPermission {
    public init() {}

    public func ensureAuthorizedIfNeeded() {
        guard CGPreflightScreenCaptureAccess() else {
            CGRequestScreenCaptureAccess()
            return
        }
    }
}
