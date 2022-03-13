import SwiftUI

struct RootView: View {
    private let configurator: Configurator

    init(configurator: Configurator) {
        self.configurator = configurator
    }

    var body: some View {
        NavigationView {
            configurator.listsView()
        }
        .navigationTitle("Shopping Lists")
        .frame(minWidth: 700, minHeight: 350)
    }
}
