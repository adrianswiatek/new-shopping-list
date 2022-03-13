import SwiftUI

extension ListsView {
    struct AddListModal: View {
        @Environment(\.dismiss)
        private var dismiss: DismissAction

        @StateObject
        private var controller: Controller

        @State
        private var listName: String

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
            self._listName = State(wrappedValue: "")
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
            Text("Add List")
        }

        private var form: some View {
            Form {
                TextField("List name", text: $listName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(12)
            .border(Color(.sRGB, white: 1, opacity: 0.15), width: 1)
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
                    withAnimation {
                        controller.addList(withName: listName)
                    }
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(width: 50)
                }
                .keyboardShortcut(.return)
                .disabled(listName.isEmpty)
            }
            .padding(.top, 8)
        }
    }
}
