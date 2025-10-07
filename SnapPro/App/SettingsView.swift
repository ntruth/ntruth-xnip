import SwiftUI
import SnapProCore

struct SettingsView: View {
    @EnvironmentObject private var environment: AppEnvironment

    var body: some View {
        Form {
            Section("导出") {
                Picker("默认格式", selection: $environment.settings.defaultExportFormat) {
                    ForEach(AppSettings.ExportFormat.allCases, id: \.self) { format in
                        Text(format.displayName).tag(format)
                    }
                }
                Toggle("自动保存到默认目录", isOn: $environment.settings.autoSave)
            }
            Section("快捷键") {
                Toggle("启用全局快捷键", isOn: $environment.settings.enableHotkeys)
            }
        }
        .padding(24)
        .frame(width: 420)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppEnvironment.preview)
    }
}
