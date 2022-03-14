import SwiftUI

extension ItemsView {
    struct ListButton: View {
        private let item: ShoppingItem
        private let isEmphasized: Bool
        private let iconSystemName: String
        private let action: () -> Void

        @State
        private var isHovered: Bool

        init(data: ListButtonData, action: @escaping () -> Void) {
            self.item = data.item
            self.isEmphasized = data.isEmphasized
            self.iconSystemName = data.iconSystemName
            self.action = action

            self._isHovered = State(wrappedValue: false)
        }

        var body: some View {
            Button {
                action()
            } label: {
                Image(systemName: iconSystemName)
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(foregroundColor)
            .onHover { isHovered = $0 }
        }

        private var foregroundColor: Color {
            if isHovered {
                return .accentColor
            }

            if isEmphasized {
                return .primary
            }

            return Color.primary.opacity(0.1)
        }
    }

    struct ListButtonData {
        let item: ShoppingItem
        let isEmphasized: Bool
        let iconSystemName: String

        private init(item: ShoppingItem, isEmphasized: Bool, iconSystemName: String) {
            self.item = item
            self.isEmphasized = isEmphasized
            self.iconSystemName = iconSystemName
        }

        static func moveToBasket(item: ShoppingItem, isEmphasized: Bool) -> ListButtonData {
            .init(item: item, isEmphasized: isEmphasized, iconSystemName: "cart.badge.plus")
        }

        static func edit(item: ShoppingItem, isEmphasized: Bool) -> ListButtonData {
            .init(item: item, isEmphasized: isEmphasized, iconSystemName: "pencil")
        }

        static func delete(item: ShoppingItem, isEmphasized: Bool) -> ListButtonData {
            .init(item: item, isEmphasized: isEmphasized, iconSystemName: "minus.circle")
        }
    }
}
