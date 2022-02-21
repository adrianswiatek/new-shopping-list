import SwiftUI

extension HomeView {
    struct SideBar: View {
        @ObservedObject
        private var controller: Controller

        @State
        private var selectedList: ShoppingList? {
            didSet {
                print(selectedList ?? "nil")
            }
        }

        @State
        private var isAddListModalVisible: Bool = false

        init(_ controller: Controller) {
            self._controller = ObservedObject(wrappedValue: controller)
        }

        var body: some View {
            VStack {
                List(controller.lists) { list in
                    NavigationLink(list.name, tag: list, selection: $selectedList) {
                        Text(list.name)
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
            .frame(minWidth: 270)
            .sheet(isPresented: $isAddListModalVisible) {
                AddListModal(controller)
            }
            .onAppear(perform: controller.fetchLists)
        }
    }
}