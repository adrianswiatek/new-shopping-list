import SwiftUI

struct ItemsView: View {
    @StateObject
    private var controller: Controller

    init(controller: Controller) {
        self._controller = StateObject(wrappedValue: controller)
    }

    var body: some View {
        TabView {
            ToBuy(controller)
                .toolbar {
                    ToolbarItem {
                        Text("ITEMS")
                    }

                    ToolbarItem {
                        Button {

                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }

            InBasket(controller)
        }
        .onAppear {
            controller.fetch()
        }
    }
}
