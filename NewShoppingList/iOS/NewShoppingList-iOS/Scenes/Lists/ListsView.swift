import SwiftUI

struct ListsView: View {
    @StateObject
    private var controller: Controller

    private let configurator: Configurator

    init(controller: Controller, configurator: Configurator) {
        self._controller = StateObject(wrappedValue: controller)
        self.configurator = configurator
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(controller.lists) { list in
                    NavigationLink(list.name, destination: configurator.itemsView(list: list))
                }
                .onDelete {
                    controller.delete($0)
                }
            }
            .listStyle(.plain)
            .refreshable {
                controller.fetch()
            }
            .navigationTitle(Text("Shopping Lists"))
            .navigationBarItems(trailing: addListBarButton)
        }
        .onAppear {
            controller.fetch()
        }
    }

    private var addListBarButton: some View {
        NavigationLink {
            configurator.addListView()
        } label: {
            Image(systemName: "plus")
        }
    }
}
