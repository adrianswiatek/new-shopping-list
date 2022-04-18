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
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    sectionText(withTitle: "Name")
                    TextField("", text: $controller.itemName)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondary.opacity(0.1))
                        )
                }

                Divider()
                    .padding(.vertical)

                VStack {
                    sectionText(withTitle: "Details")
                    TextEditor(text: $controller.itemDetails)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondary.opacity(0.1))
                        )
                        .frame(maxHeight: 100)
                }

                Spacer()
                    .frame(maxHeight: .infinity)
            }
            .padding()
            .navigationTitle(Text("Edit item"))
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
        .task {
            controller.dismissAction = dismissAction
        }
    }

    private var cancelButton: some View {
        Button(role: .cancel) {
            dismissAction()
        } label: {
            Text("Close")
        }
    }

    private var saveButton: some View {
        Button {
            withAnimation {
                controller.save()
            }
        } label: {
            Text("Save")
        }
        .disabled(controller.canSaveItem == false)
    }

    private func sectionText(withTitle title: String) -> some View {
        HStack {
            Text(title)
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}
