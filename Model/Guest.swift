// Better than acceptable is 2^n, worse is 2^n+2
public enum Match: Int {
    case unnacceptable = -8
    case poor = -4
    case acceptable = 0
    case good = 2
    case ideal = 4

    var double: Double { return Double(self.rawValue) }
}

public class Guest: Equatable, Prioritized {
    public static func == (lhs: Guest, rhs: Guest) -> Bool {
        return lhs.name == rhs.name
    }

    public var name: String
    public var preferredNeighbors: [Guest] = []
    public var incompatibleNeighbors: [Guest] = []
    public var priority: Int

    public init(name: String, priority: Int) {
        self.name = name
        self.priority = priority
    }
}

public extension Guest {
    static func match(guest1: Guest, guest2: Guest) -> Match {

        // Both want to sit next to eachother:
        if guest1.preferredNeighbors.contains(guest2) && guest2.preferredNeighbors.contains(guest1) {
            return .ideal
        }

        // Neither wants to sit with the other
        if guest1.incompatibleNeighbors.contains(guest2) && guest2.incompatibleNeighbors.contains(guest1) {
            return .unnacceptable
        }

        // Either wants to avoid the other
        if guest1.incompatibleNeighbors.contains(guest2) || guest2.incompatibleNeighbors.contains(guest1) {
            return .poor
        }

        // One would prefer to sit with the other and the other is fine with that
        if guest1.preferredNeighbors.contains(guest2) || guest2.preferredNeighbors.contains(guest1) {
            return .good
        }

        return .acceptable
    }
}
