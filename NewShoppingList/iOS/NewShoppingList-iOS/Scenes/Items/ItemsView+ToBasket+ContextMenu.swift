import SwiftUI

extension View {
    func inBasketContextMenu(item: ShoppingItem, controller: ItemsView.Controller) -> some View {
        let modifier = ItemsView.InBasketContextMenu(item: item, controller: controller)
        return ModifiedContent(content: self, modifier: modifier)
    }
}

extension ItemsView {
    fileprivate struct InBasketContextMenu: ViewModifier {
        @ObservedObject
        private var controller: Controller

        private let item: ShoppingItem

        init(item: ShoppingItem, controller: Controller) {
            self.item = item
            self._controller = ObservedObject(wrappedValue: controller)
        }

        func body(content: Content) -> some View {
            content.contextMenu {
                Button {
                    withAnimation {
                        controller.removeFromBasket(item)
                    }
                } label: {
                    Label(Message.removeFromBasket, systemImage: Icon.removeFromBasket)
                }

                Button(role: .destructive) {
                    withAnimation {
                        controller.deleteItem(item)
                    }
                } label: {
                    Label(Message.delete, systemImage: Icon.delete)
                        .foregroundColor(.red)
                }
            }
        }
    }
}
