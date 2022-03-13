import SwiftUI

extension ItemsView {
    struct Header: View {
        @State
        private var isTextFieldHovered: Bool

        @State
        private var quickAddItemName: String

        @StateObject
        private var controller: Controller

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
            self._isTextFieldHovered = State(wrappedValue: false)
            self._quickAddItemName = State(wrappedValue: "")
        }

        var body: some View {
            HStack {
                addLabel()
                addTextField()
                Spacer()
                addButton()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }

        func addLabel() -> some View {
            Label("Quick add", systemImage: "doc.badge.plus")
                .foregroundColor(.secondary)
        }

        func addTextField() -> some View {
            TextField("Item name", text: $quickAddItemName)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .inset(by: -4)
                        .fill(isTextFieldHovered ? Color(white: 1, opacity: 0.05) : Color(white: 1, opacity: 0.025))
                )
                .padding(.horizontal, 4)
                .onHover { isHovered in
                    isTextFieldHovered = isHovered
                }
        }

        func addButton() -> some View {
            Button {
                withAnimation {
                    controller.add(quickAddItemName)
                }
                quickAddItemName = ""
            } label: {
                Image(systemName: "plus")
                    .padding(.horizontal, 4)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .keyboardShortcut(KeyEquivalent.return)
            .disabled(quickAddItemName.isEmpty)
        }
    }
}
