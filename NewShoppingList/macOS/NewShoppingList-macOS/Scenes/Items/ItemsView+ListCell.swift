import SwiftUI

extension ItemsView {
    struct ListCell: View {
        private var buttons: [ListButton] {
            buttonFactories.map { $0(isHovered) }
        }

        @State
        private var isHovered: Bool

        private let item: ShoppingItem
        private let buttonFactories: [(Bool) -> ListButton]

        init(item: ShoppingItem, buttonFactories: [(Bool) -> ListButton]) {
            self.item = item
            self.buttonFactories = buttonFactories
            self._isHovered = State(wrappedValue: false)
        }

        var body: some View {
            VStack {
                HStack {
                    Text(item.name)
                    Spacer()
                    ForEach(buttons) { $0 }
                }
                .padding(.horizontal, 8)
                .background(
                    Rectangle()
                        .inset(by: -5)
                        .fill(isHovered ? Color.primary.opacity(0.05) : .clear)
                )
                .onHover { isHovered in
                    self.isHovered = isHovered
                }

                Rectangle()
                    .fill(Color.primary.opacity(0.05))
                    .frame(height: 1)
            }
        }
    }
}
