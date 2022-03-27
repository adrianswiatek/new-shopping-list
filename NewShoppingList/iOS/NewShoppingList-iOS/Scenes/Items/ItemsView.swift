import SwiftUI

struct ItemsView: View {
    @StateObject
    private var controller: Controller

    @State
    private var selectedTab: String

    private let configurator: Configurator

    init(controller: Controller, configurator: Configurator) {
        self._controller = StateObject(wrappedValue: controller)
        self.configurator = configurator

        self._selectedTab = State(wrappedValue: TabName.toBuy)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ToBuy(controller: controller, configurator: configurator)
                .tabItem {
                    Label(Message.toBuy, systemImage: Icon.toBuy)
                }
                .tag(TabName.toBuy)
                .badge(controller.numberOfItemsToBuy)

            InBasket(controller: controller)
                .tabItem {
                    Label(Message.inBasket, systemImage: Icon.inBasket)
                }
                .tag(TabName.inBasket)
                .badge(controller.numberOfItemsInBasket)
        }
        .navigationTitle(controller.listName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: controller.fetch)
    }
}
