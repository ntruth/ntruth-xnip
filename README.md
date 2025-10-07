# SnapPro 初始工程骨架

本仓库提供 macOS 截图与标注工具 **SnapPro** 的初始工程结构，覆盖核心模块的 Swift Package 架构与一套可运行的基础功能（区域截图、简易标注、复制/保存与全局快捷键桩）。

## 结构概览

```
SnapPro/
├─ App/                       # SwiftUI App 入口与 UI
├─ Packages/                  # 模块化 Swift Packages（CaptureKit/Annotator 等）
└─ Tests/                     # 预留测试目录
```

各模块功能说明：

- **CaptureKit**：区域/窗口/全屏截图与权限检测。
- **ScrollCapture**：滚动截图控制器与拼接桩实现。
- **Annotator**：标注模型、工具栏与画布渲染。
- **ExportKit**：导出、命名模板与剪贴板能力。
- **OCRKit**：基于 Vision 的 OCR 桩实现。
- **Integration**：全局快捷键、菜单栏与首启引导。
- **SnapProCore**：应用级环境与设置存储。

## 快速开始

1. 使用 Xcode 打开 `SnapPro` 目录下的工程（可自行创建 `.xcodeproj` 并引入各 Swift Package）。
2. 为 `App` target 配置签名与沙盒权限（屏幕录制）。
3. 运行后可通过菜单栏或快捷键 `⌥⇧⌘1` 启动区域截图，并在编辑器中添加标注。

## 后续规划

- 完成滚动截图的辅助功能驱动与图像拼接。
- 丰富标注工具属性（样式、撤销/重做）。
- 扩展导出格式与自动上传能力。
- 优化 OCR 识别质量与多语言支持。
- 建立自动化测试与基准评估。
