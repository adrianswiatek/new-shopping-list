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

        @Published
        var itemDetails: String
        
        @Published
        var itemCategory: String
        
        @Published
        var categories: [String]

        var canSaveItem: Bool {
            isNameProvided() && (
                isNameChanged() ||
                isDetailsChanged() ||
                isCategoryChanged()
            )
        }

        var hasDetails: Bool {
            true
        }

        private let originalItem: ShoppingItem

        init(item: ShoppingItem) {
            self.originalItem = item
            self.itemName = item.name
            self.itemDetails = item.details
            self.itemCategory = item.category
            self.categories = []
        }

        func save() {
            let updatedItem = originalItem
                .withName(itemName)
                .withDetails(itemDetails)
                .withCategory(itemCategory)

            let request = EditItem.SaveItem.Request(item: updatedItem)
            interactor?.saveItem(request: request)
        }

        func saveItem(viewModel: EditItem.SaveItem.ViewModel) {
            dismissAction?()
        }
        
        private func isNameProvided() -> Bool {
            itemName.isEmpty == false
        }

        private func isNameChanged() -> Bool {
            itemName.trimmingCharacters(in: .whitespaces) != originalItem.name
        }

        private func isDetailsChanged() -> Bool {
            itemDetails.trimmingCharacters(in: .whitespaces) != originalItem.details
        }
        
        private func isCategoryChanged() -> Bool {
            itemCategory.trimmingCharacters(in: .whitespaces) != originalItem.category
        }
    }
}
