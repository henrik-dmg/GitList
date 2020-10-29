import CLIFoundation
import Foundation
import ArgumentParser
import GitListCore

extension GitAction: EnumerableFlag {}

struct GitList: ParsableCommand {

    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "git-list", abstract: "Test Abstract")
    }

	@Flag(help: "Check out the selected branch")
	var checkout: GitAction

    func run() throws {
		do {
			let worker = GitWorker()
			try worker.listBranches(action: checkout)
		} catch let error as NSError {
			error.printAndExit(boldText: true)
		}
    }

}

GitList.main()
