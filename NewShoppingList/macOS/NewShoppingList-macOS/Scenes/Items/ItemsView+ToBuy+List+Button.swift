import SwiftUI

extension ItemsView {
    struct ListButton: View, Identifiable {
        let id: UUID

        private let isEmphasized: Bool
        private let iconSystemName: String
        private let action: () -> Void

        @State
        private var isHovered: Bool

        init(iconSystemName: String, isEmphasized: Bool, action: @escaping () -> Void) {
            self.iconSystemName = iconSystemName
            self.isEmphasized = isEmphasized
            self.action = action

            self._isHovered = State(wrappedValue: false)

            self.id = UUID()
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

    enum ListButtonFactoryCreator {
        static func delete(action: @escaping () -> Void) -> (_ isHovered: Bool) -> ListButton {
            return {
                ListButton(iconSystemName: "minus.circle", isEmphasized: $0, action: action)
            }
        }

        static func edit(action: @escaping () -> Void) -> (_ isHovered: Bool) -> ListButton {
            return {
                ListButton(iconSystemName: "pencil", isEmphasized: $0, action: action)
            }
        }

        static func removeFromBasket(action: @escaping () -> Void) -> (_ isHovered: Bool) -> ListButton {
            return {
                ListButton(iconSystemName: "cart.badge.minus", isEmphasized: $0, action: action)
            }
        }

        static func moveToBasket(action: @escaping () -> Void) -> (_ isHovered: Bool) -> ListButton {
            return {
                ListButton(iconSystemName: "cart.badge.plus", isEmphasized: $0, action: action)
            }
        }
    }
}
