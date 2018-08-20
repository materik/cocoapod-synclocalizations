
import Foundation

public protocol Localizable: RawRepresentable, CustomStringConvertible where Self.RawValue == String {
    
    var tableName: String { get }
    var bundle: Bundle { get }
    
}

public extension Localizable {

    var bundle: Bundle {
        return .main
    }
    
    var localized: String {
        return self.rawValue.localized(tableName: self.tableName, bundle: self.bundle)
    }
    
    var description: String {
        return self.localized
    }
    
}

private extension String {

    func localized(tableName: String, bundle: Bundle) -> String {
        return self.localized(tableName: tableName, bundle: bundle) ?? self.localized(bundle: bundle)
    }

    private func localized(tableName: String, bundle: Bundle) -> String? {
        let string = NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "", comment: "")
        return string == self ? nil : string
    }

    private func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: "Default", bundle: bundle, value: "", comment: "")
    }

}
