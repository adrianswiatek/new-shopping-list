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
                List(controller)
            }
            .tabItem {
                Image(systemName: "cart")
                Text("To buy")
            }
        }
    }
}
