import SwiftUI

struct EditItemView: View {
    @Environment(\.colorScheme)
    private var colorScheme: ColorScheme

    @Environment(\.dismiss)
    private var dismissAction: DismissAction

    @StateObject
    private var controller: Controller

    init(controller: Controller) {
        self._controller = StateObject(wrappedValue: controller)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Item name", text: $controller.itemName)
                    .font(.title3)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .opacity(colorScheme == .dark ? 0.2 : 0.1)
                    )

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
                    .disabled(controller.canSaveItem == false)
                }
                .padding(.vertical)
            }
            .padding(.horizontal)
            .navigationTitle(Text("Edit item"))
            .navigationViewStyle(.columns)
            .navigationBarItems(leading: HStack {
                Button(role: .cancel) {
                    dismissAction()
                } label: {
                    Text("Cancel")
                }
                Spacer()
            })
        }
        .task {
            controller.dismissAction = dismissAction
        }
    }
}
