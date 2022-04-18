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
                            Text(item.name)
                                .inBasketContextMenu(item: item, controller: controller)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    removeItemFromBasketButton(item)
                                }
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text(Message.noItemsInBasket)
                        .foregroundColor(.secondary)
                }
            }
        }

        private func removeItemFromBasketButton(_ item: ShoppingItem) -> some View {
            Button {
                withAnimation {
                    controller.removeFromBasket(item)
                }
            } label: {
                Image(systemName: Icon.removeFromBasket)
            }
            .tint(.orange)
        }
    }
}
