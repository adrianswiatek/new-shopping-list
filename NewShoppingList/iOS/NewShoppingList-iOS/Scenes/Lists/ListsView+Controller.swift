import Combine
import Foundation

protocol ListsDisplayLogic: AnyObject {
    func delete(viewModel: Lists.Delete.ViewModel)
    func fetch(viewModel: Lists.Fetch.ViewModel)
}

extension ListsView {
    final class Controller: ObservableObject, ListsDisplayLogic {
        var interactor: ListsBusinessLogic?

        @Published
        var lists: [ShoppingList]
        
        var presentationMode: PresentationMode {
            lists.isEmpty ? .empty : .filled
        }

        init() {
            self.lists = []
        }

        func delete(_ indexSet: IndexSet) {
            guard let index = indexSet.first else {
                return
            }

            let request = Lists.Delete.Request(listId: lists[index].id)
            interactor?.delete(request: request)
        }

        func delete(viewModel: Lists.Delete.ViewModel) {

        }

        func fetch() {
            let request = Lists.Fetch.Request(variant: .all)
            interactor?.fetch(request: request)
        }

        func fetch(viewModel: Lists.Fetch.ViewModel) {
            lists = viewModel.lists
        }
    }
    
    enum PresentationMode {
        case filled, empty
    }
}
