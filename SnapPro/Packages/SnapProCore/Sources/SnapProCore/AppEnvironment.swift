import Combine
import Foundation

public final class AppEnvironment: ObservableObject {
    public static var live: AppEnvironment = {
        let store = SettingsStore()
        let env = AppEnvironment(settings: store.load(), store: store)
        return env
    }()

    public static let preview = AppEnvironment(settings: .preview)

    @Published public var settings: AppSettings {
        didSet { store.save(settings) }
    }

    private let store: SettingsStore

    public init(settings: AppSettings, store: SettingsStore = SettingsStore()) {
        self.settings = settings
        self.store = store
    }
}

public struct AppSettings: Equatable, Codable {
    public enum ExportFormat: String, CaseIterable, Codable {
        case png
        case jpeg
        case pdf

        public var displayName: String {
            switch self {
            case .png: return "PNG"
            case .jpeg: return "JPEG"
            case .pdf: return "PDF"
            }
        }
    }

    public var defaultExportFormat: ExportFormat
    public var autoSave: Bool
    public var enableHotkeys: Bool
    public var launchAtLogin: Bool

    public init(defaultExportFormat: ExportFormat = .png,
                autoSave: Bool = true,
                enableHotkeys: Bool = true,
                launchAtLogin: Bool = false) {
        self.defaultExportFormat = defaultExportFormat
        self.autoSave = autoSave
        self.enableHotkeys = enableHotkeys
        self.launchAtLogin = launchAtLogin
    }
}

public extension AppSettings {
    static let preview = AppSettings()
}
