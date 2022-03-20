import SwiftUI

struct ItemsView: View {
    @StateObject
    private var controller: Controller

    init(controller: Controller) {
        self._controller = StateObject(wrappedValue: controller)
    }

    var body: some View {
        List(controller.itemsToBuy) { item in
            Text(item.name)
        }
        .listStyle(.plain)
        .navigationTitle(controller.listName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button {

            } label: {
                Image(systemName: controller.basketIcon)
            })
        .onAppear(perform: controller.fetch)
    }
}
