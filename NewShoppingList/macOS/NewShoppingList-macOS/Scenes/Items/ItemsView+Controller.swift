import Foundation

protocol ItemsDisplayLogic: AnyObject {

}

extension ItemsView {
    final class Controller: ObservableObject, ItemsDisplayLogic {
        var interactor: ItemsBusinessLogic?

        @Published
        var itemName: String

        private(set) var list: ShoppingList

        init(list: ShoppingList) {
            self.list = list
            self.itemName = ""
        }
    }
}
