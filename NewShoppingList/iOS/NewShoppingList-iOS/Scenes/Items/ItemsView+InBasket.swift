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
                            Button {
                                withAnimation {
                                    controller.removeFromBasket(item)
                                }
                            } label: {
                                Text(item.name)
                            }
                            .inBasketContextMenu(item: item, controller: controller)
                        }
                        .onDelete(perform: controller.deleteAtIndexSet)
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            EmptyView()
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text(Message.noItemsInBasket)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
