import CLIFoundation
import Foundation
import ArgumentParser
import GitListCore

struct GitList: ParsableCommand {

    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "git-list", abstract: "Test Abstract")
    }

    @Flag(help: "Check out the selected branch")
    var checkout = false

    func run() throws {
        let worker = GitWorker()
        try worker.listBranches(checkoutAfterSelection: checkout)
    }

}

GitList.main()
