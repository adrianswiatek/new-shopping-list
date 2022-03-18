import SwiftUI

extension ItemsView {
    struct ToBuy: View {
        @StateObject
        private var controller: Controller

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
        }

        var body: some View {
            VStack {
                Header(controller)

                if controller.itemsToBuy.isEmpty {
                    Spacer()
                    Text("There are not items to buy")
                    Spacer()
                } else {
                    ToBuyList(controller)
                }
            }
            .tabItem {
                Text("To buy")
            }
        }
    }
}
