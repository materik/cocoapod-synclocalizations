
import Foundation

private var DefaultValue: String = "nil"

public protocol Localizable: RawRepresentable, CustomStringConvertible where Self.RawValue == String {
    
    var table: String { get }
    var bundle: Bundle { get }
    
}

public extension Localizable {

    var bundle: Bundle {
        return .main
    }
    
    var localized: String {
        return self.rawValue.localized(table: self.table, bundle: self.bundle)
    }
    
    var description: String {
        return self.localized
    }
    
}

private extension String {

    func localized(table: String, bundle: Bundle) -> String {
        return self.localized(table: table, bundle: bundle) ?? self.localized(bundle: bundle)
    }

    private func localized(table: String, bundle: Bundle) -> String? {
        let string = bundle.localizedString(forKey: self, value: DefaultValue, table: table)
        return string == DefaultValue ? nil : string
    }

    private func localized(bundle: Bundle) -> String {
        return bundle.localizedString(forKey: self, value: DefaultValue, table: "Default")
    }

}
