import Foundation

public struct Id<T> {
    private let uuid: UUID

    private init(_ uuid: UUID) {
        self.uuid = uuid
    }

    public static func new() -> Id<T> {
        Id<T>(UUID())
    }

    public func asString() -> String {
        uuid.uuidString
    }
}

extension Id: Equatable {
    public static func == (lhs: Id, rhs: Id) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Id: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
