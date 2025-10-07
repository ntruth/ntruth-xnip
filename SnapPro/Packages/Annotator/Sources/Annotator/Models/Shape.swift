import SwiftUI

public protocol ShapeModel: Identifiable {
    var id: UUID { get }
    var frame: CGRect { get set }
    func draw(in context: inout GraphicsContext)
}
