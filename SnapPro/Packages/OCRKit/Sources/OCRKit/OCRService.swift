import AppKit

public protocol OCRService {
    func recognize(in image: NSImage, languages: [String]) async throws -> String
}
