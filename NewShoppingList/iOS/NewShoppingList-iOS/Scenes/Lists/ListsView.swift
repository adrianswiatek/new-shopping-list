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
            Group {
                switch controller.presentationMode {
                case .filled:
                    filledView
                case .empty:
                    emptyView
                }
            }
            .navigationTitle(Text("Your Lists"))
            .navigationBarItems(trailing: addListBarButton)
        }
        .onAppear {
            controller.fetch()
        }
    }
    
    private var filledView: some View {
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
    }
    
    private var emptyView: some View {
        VStack(spacing: 16) {
            Text("You have no lists added yet")
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            NavigationLink {
                configurator.addListView()
            } label: {
                Image(systemName: "plus")
                Text("tap to add")
            }
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
