import Combine
import SwiftUI

protocol AddListDisplayLogic {
    func save(viewModel: AddList.Save.ViewModel)
}

extension AddListView {
    final class Controller: NSObject, ObservableObject {
        var interactor: AddListBusinessLogic?

        @Published
        var listName: String = ""

        var isListNameEmpty: Bool {
            listName.isEmpty
        }

        var dismissAction: DismissAction?

        func reset() {
            listName = ""
        }

        func save() {
            let request = AddList.Save.Request(listName: listName)
            interactor?.save(request: request)
        }

        func save(viewModel: AddList.Save.ViewModel) {
            dismissAction?()
            reset()
        }
    }
}
