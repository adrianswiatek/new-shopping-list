import SwiftUI

struct ListsView: View {
    @ObservedObject
    private var controller: Controller

    private let configurator: Configurator

    init(controller: Controller, configurator: Configurator) {
        self.controller = controller
        self.configurator = configurator
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(controller.lists) { list in
                    Text(list.name)
                }
                .onDelete {
                    controller.delete($0)
                }
            }
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
