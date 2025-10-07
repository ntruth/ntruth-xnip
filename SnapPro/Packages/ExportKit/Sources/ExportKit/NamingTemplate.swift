import Foundation

public struct NamingTemplate {
    private let dateProvider: () -> Date

    public init(dateProvider: @escaping () -> Date = Date.init) {
        self.dateProvider = dateProvider
    }

    public func render(_ template: String, context: [String: String]) -> String {
        let pattern = #"\$\{([^}]+)\}"#
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let fullRange = NSRange(location: 0, length: template.utf16.count)
        var result = template
        let date = dateProvider()
        regex?.matches(in: template, options: [], range: fullRange).reversed().forEach { match in
            guard match.numberOfRanges > 1,
                  let range = Range(match.range(at: 0), in: template),
                  let tokenRange = Range(match.range(at: 1), in: template) else { return }
            let token = String(template[tokenRange])
            let parts = token.split(separator: ":", maxSplits: 1).map(String.init)
            let replacement: String
            if parts.count == 2, let formatted = formatSpecialToken(parts[0], format: parts[1], date: date, context: context) {
                replacement = formatted
            } else if let formatted = formatSpecialToken(parts[0], format: nil, date: date, context: context) {
                replacement = formatted
            } else {
                replacement = context[parts[0]] ?? ""
            }
            result.replaceSubrange(range, with: replacement)
        }
        return result
    }

    private func formatSpecialToken(_ key: String, format: String?, date: Date, context: [String: String]) -> String? {
        switch key {
        case "date":
            let formatter = DateFormatter()
            formatter.dateFormat = format ?? "yyyy-MM-dd"
            return formatter.string(from: date)
        case "time":
            let formatter = DateFormatter()
            formatter.dateFormat = format ?? "HH-mm-ss"
            return formatter.string(from: date)
        case "counter":
            return context[key]
        default:
            return nil
        }
    }
}
