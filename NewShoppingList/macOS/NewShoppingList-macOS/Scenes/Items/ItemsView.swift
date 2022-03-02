import SwiftUI

struct ItemsView: View {
    @StateObject
    private var controller: Controller

    init(controller: Controller) {
        self._controller = StateObject(wrappedValue: controller)
    }

    var body: some View {
        VStack {
            Spacer()
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Text("ITEMS")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }

            ToolbarItem {
                Button {

                } label: {
                    Image(systemName: "minus")
                }
                .disabled(true)
            }

            ToolbarItem {
                Button {

                } label: {
                    Image(systemName: "plus")
                }
                .disabled(true)
            }
        }
    }
}
