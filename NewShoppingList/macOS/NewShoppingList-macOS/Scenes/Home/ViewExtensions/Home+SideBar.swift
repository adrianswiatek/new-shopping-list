import SwiftUI

extension HomeView {
    struct SideBar: View {
        @ObservedObject
        private var controller: Controller

        @State
        private var isAddListModalVisible: Bool = false

        init(_ controller: Controller) {
            self._controller = ObservedObject(wrappedValue: controller)
        }

        var body: some View {
            VStack {
                List(controller.lists) { list in
                    NavigationLink {
                        Text(list.name)
                    } label: {
                        Text(list.name)
                    }
                }
                .listStyle(.inset)
                .toolbar {
                    ToolbarItem {
                        Button {
                            isAddListModalVisible = true
                        } label: {
                            Image(systemName: "plus")
                            Text("Add List")
                        }
                    }
                }
            }
            .frame(minWidth: 200)
            .sheet(isPresented: $isAddListModalVisible) {
                AddListModal(controller)
            }
        }
    }
}
