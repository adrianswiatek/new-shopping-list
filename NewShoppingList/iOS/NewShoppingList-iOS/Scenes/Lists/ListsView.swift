import SwiftUI

struct ListsView: View {
    @ObservedObject
    private var controller: Controller

    init(controller: Controller) {
        self.controller = controller
    }

    var body: some View {
        List(controller.lists) { list in
            Text(list.name)
        }
        .onAppear(perform: controller.fetch)
    }
}
