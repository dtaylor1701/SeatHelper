public class Table: Prioritized {
    public let name: String
    public let priority: Int
    public let seatNumber: Int
    public lazy private(set) var seats: [Seat] = {
        var s: [Seat] = []
        for i in 0..<seatNumber {
            s.append(Seat(table: self))
        }
        return s
    }()
    public var filledSeats: [Seat] {
        return seats.filter { $0.guest != nil }
    }
    public var isEmpty: Bool {
        return filledSeats.isEmpty
    }

    public init(name: String, priority: Int, seatNumber: Int) {
        self.name = name
        self.priority = priority
        self.seatNumber = seatNumber
    }

    public func compatibility(of guest: Guest) -> Double {
        var score: Double = 0
        for otherGuest in filledSeats.compactMap({ $0.guest }) {
            let thisMatch = Guest.match(guest1: guest, guest2: otherGuest)
            score += thisMatch.double
        }
        return score / Double(filledSeats.count)
    }

    public func describe() -> String {
        var out = "\(self.name)\n"
        out.append("--------------------------------\n")
        for seat in seats {
            out.append("| ")
            out.append(seat.describe())
            out.append("\n")
        }
        out.append("--------------------------------\n")
        return out
    }
}

public class Seat {
    public let table: Table
    public var guest: Guest?

    public init(table: Table) {
        self.table = table
    }

    public func describe() -> String {
        guard let thisGuest = guest else { return "Empty"}
        return "\(thisGuest.name), priority: \(thisGuest.priority)"
    }
}
