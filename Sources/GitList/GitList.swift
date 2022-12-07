import CLIFoundation
import Foundation
import ArgumentParser
import GitListCore

extension GitAction: EnumerableFlag {

	public static func name(for value: GitAction) -> NameSpecification {
		NameSpecification.shortAndLong
	}

}

@main
struct GitList: ParsableCommand {

    static var configuration: CommandConfiguration {
        CommandConfiguration(
			commandName: "git-list",
			abstract: "Lists all available branches and lets you quickly perform an action on them",
			version: "0.0.3"
		)
    }

	@Flag(help: "The action to perform on the branch")
	var action: GitAction?

	@Flag(name: .shortAndLong, help: "Force delete a branch if necessary")
	var force = false

    func run() throws {
		do {
			let worker = GitWorker()
			try worker.listBranches(action: action, force: force)
		} catch let error as NSError {
			error.printAndExit(boldText: true)
		}
    }

}
