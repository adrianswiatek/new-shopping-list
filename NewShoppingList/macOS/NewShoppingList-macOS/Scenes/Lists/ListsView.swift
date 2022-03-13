import SwiftUI

struct ListsView: View {
    @StateObject
    private var controller: Controller

    @State
    private var isAddListModalVisible: Bool = false

    @State
    private var selectedUuid: UUID?

    private let configurator: Configurator

    init(controller: Controller, configurator: Configurator) {
        self._controller = StateObject(wrappedValue: controller)
        self.configurator = configurator
    }

    var body: some View {
        VStack {
            List {
                ForEach(controller.lists) { list in
//                    NavigationLink(list.name) {
//                        configurator.itemsView(forList: list)
//                    }
                    NavigationLink(list.name, tag: list.id.toUuid(), selection: $selectedUuid, destination: {
                        configurator.itemsView(forList: list)
                    })
                    .badge(list.numberOfItems)
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
                            controller.deleteList(withUuid: selectedUuid)
                        }
                    } label: {
                        Image(systemName: "minus")
                    }
                    .disabled(selectedUuid == nil)
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
