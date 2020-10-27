import Foundation
import CLIFoundation

public struct GitWorker {

    public init() {}

    public func listBranches(checkoutAfterSelection: Bool) throws {
        let result = try Shell.execute("git branch")

        guard !result.output.isEmpty else {
            throw NSError(description: "Empty branch list")
        }

        let branches: [String] = result.output.map {
            let branch = $0.trimmingCharacters(in: .whitespaces)
            guard branch.hasPrefix("*") else {
                return branch
            }
            let coloredString: String = String(branch.dropFirst(1))
                .trimmingCharacters(in: .whitespaces)
                .addingTerminalColor(.green)
            return coloredString
        }

        let listString = buildList(itemKind: .branch, items: branches)
        print(listString)

        var selectedIndex = ShellReader.readInt(prompt: "Please choose a branch by entering a number:") - 1
        while !branches.indices.contains(selectedIndex) {
            selectedIndex = ShellReader.readInt(prompt: "Please choose a branch by entering a number:") - 1
        }

        try Shell.execute("git checkout \(branches[selectedIndex])")
    }

    private func buildList(itemKind: ItemKind, items: [String]) -> String {
        var constructedString = ""
        let branches = items.enumerated().map { "\($0.offset + 1): \($0.element)" }
        constructedString += branches.joined(separator: "\n")

        return constructedString
    }

}

extension String {

    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else {
            return self
        }
        return String(self.dropFirst(prefix.count))
    }

}

enum ItemKind: String {
    case branch, remote
}
