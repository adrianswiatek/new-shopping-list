import SwiftUI

extension ItemsView {
    struct EditItemModal: View {
        @Environment(\.dismiss)
        private var dismiss: DismissAction

        @StateObject
        private var controller: Controller

        @State
        private var itemName: String

        private let item: ShoppingItem

        init(item: ShoppingItem, controller: Controller) {
            self.item = item
            self._itemName = State(wrappedValue: item.name)
            self._controller = StateObject(wrappedValue: controller)
        }

        var body: some View {
            VStack(alignment: .leading) {
                title
                Spacer()
                form
                Spacer()
                buttonsBar
            }
            .padding()
            .frame(width: 300)
        }

        private var title: some View {
            Text("Edit Item")
        }

        private var form: some View {
            Form {
                TextField("Item name", text: $itemName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(12)
            .border(Color.primary.opacity(0.15), width: 1)
        }

        private var buttonsBar: some View {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .frame(width: 50)
                }
                .keyboardShortcut(.cancelAction)

                Spacer()

                Button {
                    controller.update(itemName: itemName, inItem: item)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(width: 50)
                }
                .keyboardShortcut(.defaultAction)
                .keyboardShortcut(KeyEquivalent.return)
                .disabled(itemName.isEmpty)
            }
            .padding(.top, 8)
        }
    }
}
