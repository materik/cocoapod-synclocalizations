
import Foundation

public protocol Localizable: RawRepresentable where Self.RawValue == String {
    
    var tableName: String { get }
    
}

public extension Localizable {

    var localized: String {
        return self.rawValue.localized(tableName: self.tableName)
    }

}

private extension String {

    func localized(tableName: String) -> String {
        return self.localized(tableName: tableName) ?? self.localized()
    }

    private func localized(tableName: String) -> String? {
        let string = NSLocalizedString(self, tableName: tableName, value: "", comment: "")
        return string == self ? nil : string
    }

    private func localized() -> String {
        return NSLocalizedString(self, tableName: "Default", value: "", comment: "")
    }

}
