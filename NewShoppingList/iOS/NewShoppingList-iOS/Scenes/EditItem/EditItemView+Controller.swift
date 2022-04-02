import Combine
import SwiftUI

protocol EditItemDisplayLogic: AnyObject {
    func saveItem(viewModel: EditItem.SaveItem.ViewModel)
}

extension EditItemView {
    final class Controller: ObservableObject, EditItemDisplayLogic {
        var interactor: EditItemBusinessLogic?

        var dismissAction: DismissAction?

        @Published
        var itemName: String

        var canSaveItem: Bool {
            isNameChanged() && isNameProvided()
        }

        private let originalItem: ShoppingItem

        init(item: ShoppingItem) {
            self.originalItem = item
            self.itemName = item.name
        }

        func save() {
            let updatedItem = originalItem.withName(itemName)
            let request = EditItem.SaveItem.Request(item: updatedItem)
            interactor?.saveItem(request: request)
        }

        func saveItem(viewModel: EditItem.SaveItem.ViewModel) {
            dismissAction?()
        }

        private func isNameChanged() -> Bool {
            itemName.trimmingCharacters(in: .whitespaces) != originalItem.name
        }

        private func isNameProvided() -> Bool {
            itemName.isEmpty == false
        }
    }
}
