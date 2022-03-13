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

                            Button {
                                withAnimation {
                                    controller.delete(item)
                                }
                            } label: {
                                Image(systemName: "minus.circle")
                                    .font(.title3)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(item == itemToEmphasize ? .primary : Color(.displayP3, white: 1, opacity: 0.1))

                            Button {
                                print("Edit item: \(item)")
                            } label: {
                                Image(systemName: "pencil")
                                    .font(.title3)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(item == itemToEmphasize ? .primary : Color(.displayP3, white: 1, opacity: 0.1))

                            Button {
                                print("Move item \(item) to basket")
                            } label: {
                                Image(systemName: "cart.badge.plus")
                                    .font(.title3)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(item == itemToEmphasize ? .primary : Color(.displayP3, white: 1, opacity: 0.1))
                        }
                        .padding(.horizontal, 8)
                        .background(
                            Rectangle()
                                .inset(by: -5)
                                .fill(item == itemToEmphasize ? Color(.displayP3, white: 1, opacity: 0.05) : .clear)
                        )
                        .onHover { isHovered in
                            itemToEmphasize = isHovered ? item : nil
                        }

                        Rectangle()
                            .fill(Color(.displayP3, white: 1, opacity: 0.05))
                            .frame(height: 1)
                    }
                }
            }
        }
    }
}
