import SwiftUI

extension HomeView {
    struct SideBar: View {
        @ObservedObject
        private var controller: Controller

        @State
        private var selectedList: ShoppingList?

        @State
        private var isAddListModalVisible: Bool = false

        init(_ controller: Controller) {
            self.controller = controller
        }

        var body: some View {
            VStack {
                List {
                    ForEach(controller.lists) { list in
                        NavigationLink(tag: list, selection: $selectedList) {
                            Text(list.name)
                        } label: {
                            Label(list.name, systemImage: "chevron.right")
                                .badge(list.numberOfItems)
                        }
                    }
                }
                .listStyle(.inset)
                .toolbar {
                    ToolbarItem {
                        Text("LISTS")
                            .foregroundColor(.secondary)
                    }

                    ToolbarItem {
                        Button {
                            isAddListModalVisible = true
                        } label: {
                            Image(systemName: "plus")
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
                            controller.fetchLists()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                    }
                }
            }
            .frame(minWidth: 275)
            .sheet(isPresented: $isAddListModalVisible) {
                AddListModal(controller)
            }
            .onAppear(perform: controller.fetchLists)
        }
    }
}
