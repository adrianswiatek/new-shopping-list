extension ItemsView {
    enum Icon {
        static let checkmark: String = "checkmark"
        static let delete: String = "trash.fill"
        static let edit: String = "pencil"
        static let inBasket: String = "cart.circle"
        static let info: String = "info.circle"
        static let moveToBasket: String = "cart.fill.badge.plus"
        static let quickAdd: String = "doc.badge.plus"
        static let removeFromBasket: String = "cart.fill.badge.minus"
        static let toBuy: String = "dollarsign.circle"
    }

    enum Message {
        static let delete: String = "Delete"
        static let edit: String = "Edit"
        static let inBasket: String = "In basket"
        static let moveToBasket: String = "Move to basket"
        static let noItemsInBasket: String = "There are no items in the basket"
        static let noItemsToBuy: String = "There are no items to buy"
        static let removeFromBasket: String = "Remove from basket"
        static let toBuy: String = "To buy"
    }

    enum TabName {
        static let inBasket: String = "in_basket"
        static let toBuy: String = "to_buy"
    }
}
