import SwiftUI

extension ItemsView {
    struct InBasketList: View {
        @StateObject
        private var controller: Controller

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
        }

        var body: some View {
            List(controller.itemsInBasket) { item in
                ListCell(item: item, buttonFactories: [
                    ListButtonFactoryCreator.delete {
                        withAnimation {
                            controller.delete(item)
                        }
                    },
                    ListButtonFactoryCreator.removeFromBasket {
                        withAnimation {
                            controller.removeFromBasket(item)
                        }
                    }
                ])
            }
        }
    }
}
