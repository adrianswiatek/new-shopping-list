import SwiftUI

struct ListsView: View {
    @ObservedObject
    private var controller: Controller

    init(controller: Controller) {
        self.controller = controller
    }

    var body: some View {
        VStack {
            Text("Lists")
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
        }
        .onAppear {
            controller.fetch()
        }
    }
}
