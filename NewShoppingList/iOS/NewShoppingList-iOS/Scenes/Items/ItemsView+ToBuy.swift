import SwiftUI

extension ItemsView {
    struct ToBuy: View {
        @ObservedObject
        private var controller: Controller

        @State
        private var selectedMode: Int

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
                            Button {
                                withAnimation {
                                    controller.moveToBasket(item)
                                }
                            } label: {
                                Text(item.name)
                            }
                            .toBuyContextMenu(item: item, controller: controller, configurator: configurator)
                        }
                        .onDelete(perform: controller.deleteAtIndexSet)
                    }
                    .listStyle(.plain)
                } else {
                    Spacer()
                    Text(Message.noItemsToBuy)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
        }
    }
}
