import SwiftUI

extension HomeView {
    struct AddListModal: View {
        @Environment(\.dismiss)
        private var dismiss: DismissAction

        @ObservedObject
        private var controller: Controller

        @State
        private var listName: String

        init(_ controller: Controller) {
            self._controller = ObservedObject(wrappedValue: controller)
            self._listName = State(wrappedValue: "")
        }

        var body: some View {
            VStack {
                title
                Spacer()
                form
                Spacer()
                buttonsBar
            }
            .padding()
            .frame(width: 300, height: 150)
        }

        private var title: some View {
            Text("Add List")
        }

        private var form: some View {
            Form {
                TextField("List name", text: $listName)
                    .textFieldStyle(.roundedBorder)
            }
        }

        private var buttonsBar: some View {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .keyboardShortcut(.cancelAction)

                Button {
                    controller.addList(withName: listName)
                    dismiss()
                } label: {
                    Text("Save")
                }
                .keyboardShortcut(.defaultAction)
                .disabled(listName.isEmpty)
            }
        }
    }
}
