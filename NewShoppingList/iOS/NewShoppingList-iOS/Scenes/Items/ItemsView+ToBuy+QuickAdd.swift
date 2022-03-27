import SwiftUI

extension ItemsView {
    struct QuickAdd: View {
        @ObservedObject
        private var controller: Controller

        @State
        private var quickAddItemName: String

        init(controller: Controller) {
            self._controller = ObservedObject(wrappedValue: controller)
            self._quickAddItemName = State(wrappedValue: "")
        }

        var body: some View {
            HStack {
                Image(systemName: Icon.quickAdd)
                    .font(.callout)
                    .foregroundColor(.secondary)

                TextField("Quick add", text: $quickAddItemName)

                Button {
                    withAnimation {
                        controller.addItem(withName: quickAddItemName)
                    }
                    quickAddItemName = ""
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(quickAddItemName.isEmpty)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.primary.opacity(0.05))
            )
        }
    }
}
