import SwiftUI

extension ItemsView {
    struct InBasket: View {
        @StateObject
        private var controller: Controller

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
        }

        var body: some View {
            VStack {
                if controller.itemsInBasket.isEmpty {
                    Text("There are no items in the basket")
                } else {
                    InBasketList(controller)
                }
            }
            .tabItem {
                Text("In the basket")
            }
        }
    }
}
