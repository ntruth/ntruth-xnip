import SwiftUI

public struct OnboardingGuide: View {
    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            Text("欢迎使用 SnapPro")
                .font(.title)
            Text("请在系统设置中授予屏幕录制和辅助功能权限，以便进行截图和滚动捕获。")
                .multilineTextAlignment(.center)
        }
        .padding(32)
    }
}
