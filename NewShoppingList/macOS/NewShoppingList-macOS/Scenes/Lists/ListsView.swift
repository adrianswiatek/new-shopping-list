import SwiftUI

struct ListsView: View {
    @StateObject
    private var controller: Controller

    @State
    private var isAddListModalVisible: Bool = false

    @State
    private var selectedId: Id<ShoppingList>?

    private let configurator: Configurator

    init(controller: Controller, configurator: Configurator) {
        self._controller = StateObject(wrappedValue: controller)
        self.configurator = configurator
    }

    var body: some View {
        VStack {
            List {
                ForEach(controller.lists) { list in
                    NavigationLink(list.name, tag: list.id, selection: $selectedId, destination: {
                        configurator.itemsView(forList: list)
                    })
                    .badge(list.numberOfItems(.toBuy))
                }
            }
            .listStyle(.inset)
            .toolbar {
                ToolbarItem {
                    HStack {
                        Text("LISTS")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }

                ToolbarItem {
                    Button {
                        withAnimation {
                            controller.deleteList(withId: selectedId)
                        }
                    } label: {
                        Image(systemName: "minus")
                    }
                    .disabled(selectedId == nil)
                }

                ToolbarItem {
                    Button {
                        isAddListModalVisible = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .frame(minWidth: 235)
        .sheet(isPresented: $isAddListModalVisible) {
            AddListModal(controller)
        }
        .onAppear(perform: controller.fetchLists)
    }
}
