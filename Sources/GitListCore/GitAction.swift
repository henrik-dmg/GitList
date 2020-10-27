import Foundation
import CLIFoundation

public enum GitAction {

    case checkout(_ branch: String)
    case delete(_ branch: String)

}
