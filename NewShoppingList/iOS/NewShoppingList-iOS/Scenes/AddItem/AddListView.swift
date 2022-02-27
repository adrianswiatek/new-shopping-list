import SwiftUI

struct AddListView: View {
    @Environment(\.dismiss) var dismissAction: DismissAction

    @ObservedObject
    private var controller: Controller

    init(controller: Controller) {
        self.controller = controller
        self.controller.onListSaved = dismiss
    }

    var body: some View {
        VStack {
            Text("Add new list")
                .fontWeight(.semibold)
                .font(.title2)

            TextField("List name", text: $controller.listName)
                .font(.title3)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, white: 0, opacity: 0.25), lineWidth: 1)
                )

            HStack {
                Spacer()
                Button {
                    controller.save()
                } label: {
                    Label("OK", systemImage: "checkmark")
                        .font(.title3)
                }
                .buttonStyle(.borderedProminent)
                .disabled(controller.isListNameEmpty)
            }
            .padding(.vertical)

            Spacer()
        }
        .padding(.top, -32)
        .padding(.horizontal)
        .onAppear(perform: controller.reset)
    }

    private func dismiss() {
        dismissAction()
    }
}
