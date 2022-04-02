import SwiftUI

extension View {
    func toBuyContextMenu(item: ShoppingItem, controller: ItemsView.Controller, configurator: Configurator) -> some View {
        let modifier = ItemsView.ToBuyContextMenu(item: item, controller: controller, configurator: configurator)
        return ModifiedContent(content: self, modifier: modifier)
    }
}

extension ItemsView {
    fileprivate struct ToBuyContextMenu: ViewModifier {
        @ObservedObject
        private var controller: Controller

        @State
        private var isEditItemVisible: Bool

        private let configurator: Configurator
        private let item: ShoppingItem

        init(item: ShoppingItem, controller: Controller, configurator: Configurator) {
            self.item = item
            self._controller = ObservedObject(wrappedValue: controller)
            self.configurator = configurator

            self._isEditItemVisible = State(wrappedValue: false)
        }

        func body(content: Content) -> some View {
            content.contextMenu {
                Button {
                    withAnimation {
                        controller.moveToBasket(item)
                    }
                } label: {
                    Label(Message.moveToBasket, systemImage: Icon.moveToBasket)
                }

                Button {
                    isEditItemVisible = true
                } label: {
                    Label(Message.edit, systemImage: Icon.edit)
                }

                Button(role: .destructive) {
                    controller.deleteItem(item)
                } label: {
                    Label(Message.delete, systemImage: Icon.delete)
                        .foregroundColor(.red)
                }
            }
            .popover(isPresented: $isEditItemVisible) {
                configurator.editItemView(item: item)
            }
        }
    }
}
