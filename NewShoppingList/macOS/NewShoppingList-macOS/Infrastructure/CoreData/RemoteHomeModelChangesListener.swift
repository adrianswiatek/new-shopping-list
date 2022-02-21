import Foundation

protocol RemoteHomeModelChangesListenerDelegate: AnyObject {
    func shoppingListsDidChangeFromRemote(_ listener: RemoteHomeModelChangesListener)
}

final class RemoteHomeModelChangesListener {
    weak var delegate: RemoteHomeModelChangesListenerDelegate?

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didChangeNotification),
            name: .init(rawValue: "HomeModelChangedFromRemote"),
            object: nil
        )
    }

    @objc
    private func didChangeNotification(_ notification: Notification) {
        delegate?.shoppingListsDidChangeFromRemote(self)
    }
}
