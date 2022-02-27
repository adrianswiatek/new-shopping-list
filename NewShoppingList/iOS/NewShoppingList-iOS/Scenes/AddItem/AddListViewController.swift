import Combine

protocol AddListDisplayLogic {
    func save(viewModel: AddList.Save.ViewModel)
}

extension AddListView {
    final class Controller: ObservableObject {
        var interactor: AddListBusinessLogic?

        @Published
        var listName: String = ""

        var isListNameEmpty: Bool {
            listName.isEmpty
        }

        var onListSaved: (() -> Void)?

        func reset() {
            listName = ""
        }

        func save() {
            let request = AddList.Save.Request(listName: listName)
            interactor?.save(request: request)
        }

        func save(viewModel: AddList.Save.ViewModel) {
            onListSaved?()
        }
    }
}
