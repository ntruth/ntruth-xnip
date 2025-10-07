import XCTest
@testable import SnapProCore

final class PlaceholderTests: XCTestCase {
    func testSettingsEncoding() throws {
        let store = SettingsStore(defaults: UserDefaults(suiteName: "test")!)
        let original = AppSettings(defaultExportFormat: .jpeg, autoSave: false, enableHotkeys: true, launchAtLogin: true)
        store.save(original)
        let loaded = store.load()
        XCTAssertEqual(original, loaded)
    }
}
