import Combine
import Foundation

public final class SettingsStore {
    private enum Keys {
        static let defaultsKey = "app.settings"
    }

    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public func load() -> AppSettings {
        guard let data = defaults.data(forKey: Keys.defaultsKey),
              let settings = try? decoder.decode(AppSettings.self, from: data) else {
            return .init()
        }
        return settings
    }

    public func save(_ settings: AppSettings) {
        guard let data = try? encoder.encode(settings) else { return }
        defaults.set(data, forKey: Keys.defaultsKey)
    }
}
