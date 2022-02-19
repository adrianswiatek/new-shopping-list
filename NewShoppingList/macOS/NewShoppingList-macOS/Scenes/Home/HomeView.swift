import SwiftUI

struct HomeView: View {
    @ObservedObject
    private var controller: Controller

    init(controller: Controller) {
        _controller = ObservedObject(wrappedValue: controller)
    }

    var body: some View {
        NavigationView {
            SideBar(controller)
            Text("Main view")
        }
    }
}
