import SwiftUI

extension ItemsView {
    struct ToBuyList: View {
        @StateObject
        private var controller: Controller

        init(_ controller: Controller) {
            self._controller = StateObject(wrappedValue: controller)
        }

        var body: some View {
            List(controller.itemsToBuy) { item in
                ListCell(item: item, buttonFactories: [
                    ListButtonFactoryCreator.delete {
                        withAnimation {
                            controller.delete(item)
                        }
                    },
                    ListButtonFactoryCreator.edit {
                        print("Edit item")
                    },
                    ListButtonFactoryCreator.moveToBasket {
                        withAnimation {
                            controller.moveToBasket(item)
                        }
                    }
                ])
            }
        }
    }
}
