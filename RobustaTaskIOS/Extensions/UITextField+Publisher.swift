import Combine
import UIKit

public extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .map { self.text ?? "" }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    /// A publisher that emits whenever the user taps the text fields and begin the editing.
    var textPublisherDidEnd: AnyPublisher<String, Never> {
        publisher(for: .editingDidEnd)
            .map { self.text ?? "" }
            .eraseToAnyPublisher()
    }
}
