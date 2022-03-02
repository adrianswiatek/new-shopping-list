import SwiftUI

struct ListsView: View {
    @ObservedObject
    private var controller: Controller

    @State
    private var selectedList: ShoppingList?

    @State
    private var isAddListModalVisible: Bool = false

    private let configurator: Configurator

    init(controller: Controller, configurator: Configurator) {
        self.controller = controller
        self.configurator = configurator
    }

    var body: some View {
        VStack {
            List {
                ForEach(controller.lists) { list in
                    NavigationLink(tag: list, selection: $selectedList) {
                        configurator.itemsView(forList: list)
                    } label: {
                        Label(list.name, systemImage: "chevron.right")
                            .badge(list.numberOfItems)
                    }
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
                            controller.deleteList(selectedList)
                        }
                    } label: {
                        Image(systemName: "minus")
                    }
                    .disabled(selectedList == nil)
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
