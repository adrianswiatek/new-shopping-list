import SwiftUI

extension ItemsView {
    struct InBasket: View {
        @ObservedObject
        private var controller: Controller

        init(controller: Controller) {
            self._controller = ObservedObject(wrappedValue: controller)
        }

        var body: some View {
            Group {
                if controller.hasItemsInBasket {
                    List {
                        ForEach(controller.itemsInBasket) { item in
                            cellButtonForItem(item)
                                .inBasketContextMenu(item: item, controller: controller)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    deleteItemButton(item)
                                }
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        controller.fetch()
                    }
                } else {
                    Text(Message.noItemsInBasket)
                        .foregroundColor(.secondary)
                }
            }
        }
        
        private func cellButtonForItem(_ item: ShoppingItem) -> some View {
            Button {
                withAnimation {
                    controller.removeFromBasket(item)
                }
            } label: {
                Text(item.name)
            }
        }

        private func deleteItemButton(_ item: ShoppingItem) -> some View {
            Button {
                withAnimation {
                    controller.deleteItem(item)
                }
            } label: {
                Image(systemName: Icon.delete)
            }
            .tint(Color.red)
        }
    }
}
