enum SeatingError: Error {
    case notEnoughSeats
}

class SeatHelper {
    var tables: [Table]
    var guests: [Guest]

    init(tables: [Table], guests: [Guest]) {
        self.tables = tables
        self.guests = guests
    }

    func seatGuests() throws {

        let sortedTables = tables.prioritySorted()
        var sortedGuests = guests.prioritySorted()

        let seats = sortedTables.flatMap({ $0.seats })
        if seats.count < sortedGuests.count {
            throw SeatingError.notEnoughSeats
        }

        for seat in seats {
            if sortedGuests.isEmpty { break }
            let (nextGuest, guestIndex) = bestGuest(from: sortedGuests, for: seat.table)
            seat.guest = nextGuest
            sortedGuests.remove(at: guestIndex)
        }
    }

    func bestGuest(from guests: [Guest], for table: Table) -> (Guest, Int) {
        if table.isEmpty {
            return (guests[0], 0)
        }
        var bestScore: Double?
        var bestIndex: Int = 0
        for i in 0..<guests.count {
            let thisMatch = table.compatibility(of: guests[i])
            guard let best = bestScore else {
                bestScore = thisMatch
                bestIndex = i
                continue
            }

            if best < thisMatch {
                bestScore = thisMatch
                bestIndex = i
            }
        }
        print("Match: \(bestScore!)")
        return (guests[bestIndex], bestIndex)
    }
}
