import SwiftUI

extension ItemsView {
    struct ToBuy: View {
        @ObservedObject
        private var controller: Controller

        @State
        private var selectedMode: Int

        @State
        private var itemToEdit: ShoppingItem?

        private let configurator: Configurator

        init(controller: Controller, configurator: Configurator) {
            self._controller = ObservedObject(wrappedValue: controller)
            self.configurator = configurator

            self._selectedMode = State(wrappedValue: 0)
        }

        var body: some View {
            VStack {
                QuickAdd(controller: controller)
                    .padding(.horizontal, 8)

                if controller.hasItemsToBuy {
                    List {
                        ForEach(controller.itemsToBuy) { item in
                            cellButton(forItem: item)
                                .toBuyContextMenu(item: item, controller: controller, configurator: configurator)
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    editItemButton(item)
                                }
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
                    Spacer()
                    Text(Message.noItemsToBuy)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .popover(item: $itemToEdit) { item in
                configurator.editItemView(item: item)
            }
        }

        private func cellButton(forItem item: ShoppingItem) -> some View {
            Button {
                withAnimation {
                    controller.moveToBasket(item)
                }
            } label: {
                HStack {
                    Text(item.name)
                    
                    Spacer()
                    
                    if item.hasCategory {
                        Image(systemName: "tag")
                            .foregroundColor(.secondary)
                    }

                    if item.hasDetails {
                        Image(systemName: Icon.info)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }

        private func editItemButton(_ item: ShoppingItem) -> some View {
            Button {
                withAnimation {
                    itemToEdit = item
                }
            } label: {
                Image(systemName: Icon.edit)
            }
            .tint(Color.blue)
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
