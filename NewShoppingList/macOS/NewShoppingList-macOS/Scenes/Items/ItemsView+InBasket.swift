import SwiftUI

extension ItemsView {
    struct InBasket: View {
        @StateObject
        private var controller: Controller

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
        }

        var body: some View {
            Text("There are no items in the basket")
                .badge(10)
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("In the basket")
                }
        }
    }
}
