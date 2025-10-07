import SwiftUI

public struct ToolboxView: View {
    @Binding var selectedTool: Tool

    public init(selectedTool: Binding<Tool>) {
        _selectedTool = selectedTool
    }

    public var body: some View {
        HStack(spacing: 12) {
            ForEach(Tool.allCases, id: \.self) { tool in
                Button(action: { selectedTool = tool }) {
                    Label(tool.title, systemImage: tool.icon)
                }
                .buttonStyle(.borderedProminent)
                .tint(selectedTool == tool ? .accentColor : .gray)
            }
            Spacer()
        }
        .padding(12)
        .background(Material.bar)
    }
}

private extension Tool {
    var title: String {
        switch self {
        case .rectangle: return "矩形"
        case .arrow: return "箭头"
        case .text: return "文本"
        case .blur: return "马赛克"
        }
    }

    var icon: String {
        switch self {
        case .rectangle: return "square"
        case .arrow: return "arrow.right"
        case .text: return "textformat"
        case .blur: return "drop"
        }
    }
}
