import SwiftUI
import SnapProCore
import CaptureKit

struct ContentView: View {
    @EnvironmentObject private var environment: AppEnvironment

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SnapPro")
                .font(.headline)
            Text("快速截图与标注工具")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Divider()
            Button("区域截图 (⌥⇧⌘1)") {
                CaptureService.shared.captureRegion()
            }
            Button("窗口截图 (⌥⇧⌘2)") {
                CaptureService.shared.captureWindow()
            }
            Button("全屏截图 (⌥⇧⌘3)") {
                CaptureService.shared.captureScreen()
            }
            Divider()
            Toggle("开机自动启动", isOn: $environment.settings.launchAtLogin)
            Spacer()
        }
        .padding(16)
        .frame(width: 280)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppEnvironment.preview)
    }
}
