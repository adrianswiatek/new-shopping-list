import SwiftUI

extension ItemsView {
    struct ToBuyList: View {
        @StateObject
        private var controller: Controller

        @State
        private var editingItem: ShoppingItem?

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
            self._editingItem = State(wrappedValue: nil)
        }

        var body: some View {
            List(controller.itemsToBuy) { item in
                ListCell(item: item, buttonFactories: [
                    ListButtonFactoryCreator.delete {
                        withAnimation {
                            controller.delete(item)
                        }
                    },
                    ListButtonFactoryCreator.edit {
                        editingItem = item
                    },
                    ListButtonFactoryCreator.moveToBasket {
                        withAnimation {
                            controller.moveToBasket(item)
                        }
                    }
                ])
            }
            .sheet(item: $editingItem) { item in
                EditItemModal(item: item, controller: controller)
            }
        }
    }
}
