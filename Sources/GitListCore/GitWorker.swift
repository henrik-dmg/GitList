import Foundation
import CLIFoundation

public struct GitWorker {

    public init() {}

	public func listBranches(action: GitAction, force: Bool) throws {
		let result = try Shell.execute("git branch", errorHandle: .standardError)

        guard !result.output.isEmpty else {
            throw NSError(description: "Empty branch list")
        }

        let branches: [Branch] = result.output.map {
			Branch(name: $0)
        }

		let commands = branches.map { branch in
			ConsoleMenuCommand(title: branch.coloredName) {
				switch action {
				case .checkout:
					try Shell.execute("git checkout \(branch.name)", expectedReturnCode: 0, outputHandle: .standardOutput)
				case .delete:
					let command = force ? "git branch -D \(branch.name)" : "git branch -d \(branch.name)"
					try Shell.execute(command, expectedReturnCode: 0, outputHandle: .standardOutput)
				}
			}
		}

		let menu = ConsoleMenu(title: "Available branches", commands: commands)
		try menu.present()
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

struct Branch {
	let name: String
	let isCurrent: Bool

	var coloredName: String {
		isCurrent ? name.addingTerminalColor(.green) : name
	}

	init(name: String) {
		isCurrent = name.hasPrefix("*")
		if name.hasPrefix("*") {
			self.name = String(name.dropFirst()).trimmingCharacters(in: .whitespaces)
		} else {
			self.name = String(name.dropFirst()).trimmingCharacters(in: .whitespaces)
		}
	}

}

enum ItemKind: String {
    case branch, remote
}
