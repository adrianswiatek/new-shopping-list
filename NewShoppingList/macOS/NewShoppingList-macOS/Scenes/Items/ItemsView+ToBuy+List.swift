import SwiftUI

extension ItemsView {
    struct List: View {
        @State
        private var itemToEmphasize: ShoppingItem?

        @StateObject
        private var controller: Controller

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
        }

        var body: some View {
            SwiftUI.List {
                ForEach(controller.items) { item in
                    VStack {
                        HStack {
                            Text(item.name)

                            Spacer()

                            ListButton(data: .delete(item: item, isEmphasized: isEmphasized(item))) {
                                withAnimation {
                                    controller.delete(item)
                                }
                            }

                            ListButton(data: .edit(item: item, isEmphasized: isEmphasized(item))) {
                                print("Edit item")
                            }

                            ListButton(data: .moveToBasket(item: item, isEmphasized: isEmphasized(item))) {
                                print("Move to the basket")
                            }
                        }
                        .padding(.horizontal, 8)
                        .background(
                            Rectangle()
                                .inset(by: -5)
                                .fill(isEmphasized(item) ? Color.primary.opacity(0.05) : .clear)
                        )
                        .onHover { isHovered in
                            itemToEmphasize = isHovered ? item : nil
                        }

                        Rectangle()
                            .fill(Color.primary.opacity(0.05))
                            .frame(height: 1)
                    }
                }
            }
        }

        private func isEmphasized(_ item: ShoppingItem) -> Bool {
            item == itemToEmphasize
        }
    }
}
