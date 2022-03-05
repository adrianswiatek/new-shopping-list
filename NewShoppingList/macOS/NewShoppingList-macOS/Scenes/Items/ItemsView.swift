import SwiftUI

struct ItemsView: View {
    @StateObject
    private var controller: Controller

    @State
    private var itemsInCategories: [String: [String]] = [
        "Other": ["Other 1", "Other 2", "Other 3", "Other 4", "Other 5", "Other 6", "Other 7", "Other 8"],
        "Important": ["Important 1", "Important 2", "Important 3", "Important 4", "Important 5", "Important 6", "Important 7", "Important 8"]
    ]

    @State
    private var itemToEmphasize: String?

    @State
    private var isTextFieldHovered: Bool

    @State
    private var quickAddItem: String

    init(controller: Controller) {
        self._controller = StateObject(wrappedValue: controller)
        self._quickAddItem = State(wrappedValue: "")
        self._isTextFieldHovered = State(wrappedValue: false)
    }

    var body: some View {
        TabView {
            VStack {
                HStack {
                    Text("Quick add")
                        .foregroundColor(.secondary)
                    TextField("Item name", text: $quickAddItem)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.horizontal, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: -4)
                                .fill(isTextFieldHovered ? Color(white: 1, opacity: 0.05) : Color(white: 1, opacity: 0.025))
                        )
                        .padding(.horizontal, 4)
                        .onHover { isHovered in
                            isTextFieldHovered = isHovered
                        }
                    Spacer()
                    Button {
                        withAnimation {
                            itemsInCategories["Other"]?.append(quickAddItem)
                        }
                        quickAddItem = ""
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .keyboardShortcut(KeyEquivalent.return)
                    .disabled(quickAddItem.isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

                List {
                    ForEach(itemsInCategories.keys.map { $0 }, id: \.self) { category in
                        Section {
                            ForEach(itemsInCategories[category]!, id: \.self) { item in
                                VStack {
                                    HStack {
                                        Text(item)

                                        Spacer()

                                        Button {
                                            withAnimation {
                                                itemsInCategories[category]?.removeAll { $0 == item }
                                            }
                                        } label: {
                                            Image(systemName: "minus.circle")
                                                .font(.title3)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .foregroundColor(item == itemToEmphasize ? .primary : Color(.displayP3, white: 1, opacity: 0.1))

                                        Button {
                                            print("Edit item: \(item)")
                                        } label: {
                                            Image(systemName: "pencil")
                                                .font(.title3)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .foregroundColor(item == itemToEmphasize ? .primary : Color(.displayP3, white: 1, opacity: 0.1))

                                        Button {
                                            print("Move item \(item) to basket")
                                        } label: {
                                            Image(systemName: "cart.badge.plus")
                                                .font(.title3)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .foregroundColor(item == itemToEmphasize ? .primary : Color(.displayP3, white: 1, opacity: 0.1))
                                    }
                                    .padding(.horizontal, 8)
                                    .background(
                                        Rectangle()
                                            .inset(by: -5)
                                            .fill(item == itemToEmphasize ? Color(.displayP3, white: 1, opacity: 0.05) : .clear)
                                    )
                                    .onHover { isHovered in
                                        itemToEmphasize = isHovered ? item : nil
                                    }

                                    Rectangle()
                                        .fill(Color(.displayP3, white: 1, opacity: 0.05))
                                        .frame(height: 1)
                                }
                            }
                        } header: {
                            Text(category)
                                .badge(itemsInCategories[category]!.count)
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "cart")
                Text("Items")
            }
            .toolbar {
                ToolbarItem {
                    Text("ITEMS")
                }

                ToolbarItem {
                    Button {

                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }

            Text("There are not items in the basket")
                .badge(10)
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Basket")
                }
        }
    }
}

