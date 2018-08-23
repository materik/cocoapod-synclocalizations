
import SyncLocalizations

enum Strings: String, Localizable {

    case title
    case description
    case descriptionNumber1
    case descriptionNumber2
    
    var table: String {
        return Mode.mode1.table
    }

}

private extension Mode {
    
    var table: String {
        switch self {
        case .mode1: return "Localizable1"
        case .mode2: return "Localizable2"
        }
    }
    
}
