import os.log

fileprivate let logSubsystem = "com.snappro.app"

public enum Log {
    public static func capture(_ message: String) {
        os_log("%{public}@", log: .capture, type: .info, message)
    }

    public static func error(_ message: String) {
        os_log("%{public}@", log: .general, type: .error, message)
    }
}

private extension OSLog {
    static let general = OSLog(subsystem: logSubsystem, category: "general")
    static let capture = OSLog(subsystem: logSubsystem, category: "capture")
}
