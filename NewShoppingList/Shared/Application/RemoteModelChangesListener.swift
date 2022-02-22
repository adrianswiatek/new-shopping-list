import Foundation

protocol RemoteModelChangesListenerDelegate: AnyObject {
    func shoppingListsDidChangeFromRemote(_ listener: RemoteModelChangesListener)
}

final class RemoteModelChangesListener {
    weak var delegate: RemoteModelChangesListenerDelegate?

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didChangeNotification),
            name: .init(rawValue: "ModelChangedFromRemote"),
            object: nil
        )
    }

    @objc
    private func didChangeNotification(_ notification: Notification) {
        delegate?.shoppingListsDidChangeFromRemote(self)
    }
}
