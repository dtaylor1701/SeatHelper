import XCTest
@testable import SeatHelper

final class SeatHelperTests: XCTestCase {
    func test() {
        let tables = testTables
        let guests = testGuests
        let helper = SeatHelper(tables: tables, guests: guests)

        try? helper.seatGuests()

        for table in tables {
            print(table.describe())
        }
    }

    func testTableCompatibility() {
        let firstGuest = Guest(name: "Guest 1", priority: 0)
        let secondGuest = Guest(name: "Guets 2", priority: 0)

        let table = Table(name: "Table 1", priority: 0, seatNumber: 2)
        table.seats.first?.guest = firstGuest

        firstGuest.preferredNeighbors = [secondGuest]
        secondGuest.preferredNeighbors = [firstGuest]

        XCTAssertEqual(table.compatibility(of: secondGuest), 4)

        secondGuest.preferredNeighbors = []
        XCTAssertEqual(table.compatibility(of: secondGuest), 2)

        firstGuest.preferredNeighbors = []
        XCTAssertEqual(table.compatibility(of: secondGuest), 0)

        secondGuest.incompatibleNeighbors = [firstGuest]
        XCTAssertEqual(table.compatibility(of: secondGuest), -4)

        firstGuest.incompatibleNeighbors = [secondGuest]
        XCTAssertEqual(table.compatibility(of: secondGuest), -8)


    }

    static var allTests = [
        ("test", test),
    ]
}

var testTables: [Table] {
    let table1 = Table(name: "Table 1", priority: 0, seatNumber: 5)
    let table2 = Table(name: "Table 2", priority: 1, seatNumber: 5)
    let table3 = Table(name: "Table 3", priority: 2, seatNumber: 5)
    let table4 = Table(name: "Table 4", priority: 3, seatNumber: 5)

    return [table1,
            table2,
            table3,
            table4
    ]
}

var testGuests: [Guest] {
    let harry = Guest(name: "harry", priority: 0)
    let harry1 = Guest(name: "harry1", priority: 0)
    let harry2 = Guest(name: "harry2", priority: 0)
    let harry3 = Guest(name: "harry3", priority: 1)
    let harry4 = Guest(name: "harry4", priority: 0)
    let harry5 = Guest(name: "harry5", priority: 1)
    let harry6 = Guest(name: "harry6", priority: 0)
    let harry7 = Guest(name: "harry7", priority: 1)
    let harry8 = Guest(name: "harry8", priority: 0)
    let harry9 = Guest(name: "harry9", priority: 0)
    let harry10 = Guest(name: "harry10", priority: 0)
    let harry11 = Guest(name: "harry11", priority: 1)
    let harry12 = Guest(name: "harry12", priority: 0)
    let harry13 = Guest(name: "harry13", priority: 0)
    let harry14 = Guest(name: "harry14", priority: 1)
    let harry15 = Guest(name: "harry15", priority: 0)
    let harry16 = Guest(name: "harry16", priority: 1)
    let harry17 = Guest(name: "harry17", priority: 0)

    harry1.preferredNeighbors = [harry17, harry12]
    harry1.incompatibleNeighbors = [harry4, harry10]

    harry6.preferredNeighbors = [harry9, harry15]
    harry6.incompatibleNeighbors = [harry17, harry1]

    harry12.preferredNeighbors = [harry1, harry5]
    harry12.incompatibleNeighbors = [harry9, harry15]

    harry16.preferredNeighbors = [harry17, harry8]
    harry16.incompatibleNeighbors = [harry4, harry6]

    harry7.preferredNeighbors = [harry3, harry]
    harry7.incompatibleNeighbors = [harry17, harry14]

    harry8.preferredNeighbors = [harry9, harry7]
    harry8.incompatibleNeighbors = [harry4, harry9]

    harry4.preferredNeighbors = [harry15, harry2]
    harry4.incompatibleNeighbors = [harry16, harry10]

    harry13.preferredNeighbors = [harry2, harry12]
    harry13.incompatibleNeighbors = [harry4, harry11]

    return [harry,
            harry1,
            harry2,
            harry3,
            harry4,
            harry5,
            harry6,
            harry7,
            harry8,
            harry9,
            harry10,
            harry11,
            harry12,
            harry13,
            harry14,
            harry15,
            harry16,
            harry17
    ]
}
