import SwiftUI

struct EditItemView: View {
    @Environment(\.colorScheme)
    private var colorScheme: ColorScheme
    
    @Environment(\.dismiss)
    private var dismissAction: DismissAction
    
    @State
    private var isMoreMenuShowing: Bool
    
    @StateObject
    private var controller: Controller
    
    init(controller: Controller) {
        self._controller = StateObject(wrappedValue: controller)
        self._isMoreMenuShowing = State(wrappedValue: false)
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    sectionText(withTitle: "Name")
                    TextField("", text: $controller.itemName)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondary.opacity(0.1))
                        )
                }
                
                sectionDivider
                
                VStack {
                    sectionText(withTitle: "Details")
                    TextEditor(text: $controller.itemDetails)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondary.opacity(0.1))
                        )
                        .frame(maxHeight: 100)
                }
                
                sectionDivider
                
                VStack {
                    sectionText(withTitle: "Category")
                                        
                    HStack {
                        TextField("", text: $controller.itemCategory)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.secondary.opacity(0.1))
                            )
                        
                        NavigationLink {
                            
                        } label: {
                            Image(systemName: "tag.fill")
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.secondary.opacity(0.1))
                                )
                        }
                    }
                }
                
                sectionDivider
                
                Button {
                    isMoreMenuShowing = true
                } label: {
                    Image(systemName: "ellipsis")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondary.opacity(0.1))
                        )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
                    .frame(maxHeight: .infinity)
            }
            .padding()
            .navigationTitle(Text("Edit item"))
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
        .confirmationDialog("More", isPresented: $isMoreMenuShowing, actions: {
            Button("Reset") {}
            Button("Move to basket") {
                controller.dismissAction?()
            }
            Button("Remove", role: .destructive) {
                controller.dismissAction?()
            }
            Button("Cancel", role: .cancel) {}
        })
        .task {
            controller.dismissAction = dismissAction
        }
    }
    
    private var sectionDivider: some View {
        Divider()
            .padding(.vertical)
    }
    
    private var cancelButton: some View {
        Button(role: .cancel) {
            dismissAction()
        } label: {
            Text("Close")
        }
    }
    
    private var saveButton: some View {
        Button {
            withAnimation {
                controller.save()
            }
        } label: {
            Text("Save")
        }
        .disabled(controller.canSaveItem == false)
    }
    
    private func sectionText(withTitle title: String) -> some View {
        HStack {
            Text(title)
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}
