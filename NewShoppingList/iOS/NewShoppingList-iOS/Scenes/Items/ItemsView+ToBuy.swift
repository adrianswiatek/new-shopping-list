import SwiftUI

extension ItemsView {
    struct ToBuy: View {
        @ObservedObject
        private var controller: Controller

        @State
        private var quickAdd: String

        init(controller: Controller) {
            self._controller = ObservedObject(wrappedValue: controller)
            self._quickAdd = State(wrappedValue: "")
        }

        var body: some View {
            VStack {
                HStack {
                    TextField("Quick add", text: $quickAdd)

                    Button {

                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(quickAdd.isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.primary.opacity(0.05))
                )

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
                        }
                        .onDelete(perform: controller.delete)
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
