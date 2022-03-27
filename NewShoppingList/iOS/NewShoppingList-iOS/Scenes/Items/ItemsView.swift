import SwiftUI

struct ItemsView: View {
    @StateObject
    private var controller: Controller

    @State
    private var selectedTab: String

    init(controller: Controller) {
        self._controller = StateObject(wrappedValue: controller)
        self._selectedTab = State(wrappedValue: Message.toBuy)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ToBuy(controller: controller)
                .tabItem {
                    Label(Message.toBuy, systemImage: Icon.toBuy)
                }
                .tag(Message.toBuy)
            InBasket(controller: controller)
                .tabItem {
                    Label(Message.inBasket, systemImage: Icon.inBasket)
                }
                .tag(Message.inBasket)
        }
        .navigationTitle(controller.listName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: controller.fetch)
    }
}
