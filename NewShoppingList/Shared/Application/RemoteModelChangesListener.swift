import Combine
import Foundation

final class RemoteModelChangesListener {
    var publisher: AnyPublisher<ShoppingList, Never> {
        subject.share().eraseToAnyPublisher()
    }

    private let subject: PassthroughSubject<ShoppingList, Never>

    init() {
        subject = PassthroughSubject<ShoppingList, Never>()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didChangeNotification),
            name: .init(rawValue: "ShoppingListEntityHaveChanged"),
            object: nil
        )
    }

    @objc
    private func didChangeNotification(_ notification: Notification) {
        guard let shoppingList = notification.object as? ShoppingList else {
            return
        }

        subject.send(shoppingList)
    }
}
