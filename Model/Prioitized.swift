public protocol Prioritized {
    var priority: Int { get }
}

public extension Array where Element: Prioritized {
    func prioritySorted() -> [Element] {
        var result: [Element] = []
        let priorites = Set(self.map({ $0.priority })).sorted()
        for level in priorites {
            result.append(contentsOf: self.filter({ $0.priority == level }).shuffled())
        }
        return result
    }
}
