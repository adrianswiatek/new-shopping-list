import SwiftUI

struct AddListView: View {
    @Environment(\.dismiss)
    private var dismissAction: DismissAction

    @Environment(\.colorScheme)
    private var colorScheme: ColorScheme

    @FocusState
    private var isFocusedOnListName: Bool

    @StateObject
    private var controller: Controller

    init(controller: Controller) {
        self._controller = StateObject(wrappedValue: controller)
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
                        .opacity(colorScheme == .dark ? 0.2 : 0.1)
                )
                .focused($isFocusedOnListName)

            HStack {
                Spacer()
                Button {
                    withAnimation {
                        controller.save()
                    }
                } label: {
                    Label("Save", systemImage: "checkmark")
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
        .task {
            controller.reset()
            controller.dismissAction = dismissAction
            await focusOnListName()
        }
    }

    private func focusOnListName() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        isFocusedOnListName = true
    }
}
