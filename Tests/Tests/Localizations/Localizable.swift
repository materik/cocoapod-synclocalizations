
import Foundation

protocol Localizable: RawRepresentable where Self.RawValue == String {}

extension Localizable {

    var localized: String {
        return self.rawValue.localized(localizableStrings: LocalizableStrings.l2)
    }

}

private enum LocalizableStrings: String {

    case l1 = "Localizable1"
    case l2 = "Localizable2"

    var tableName: String {
        return self.rawValue
    }

}

private extension String {

    func localized(localizableStrings: LocalizableStrings) -> String {
        return self.localized(localizableStrings: localizableStrings) ?? self.localized()
    }

    private func localized(localizableStrings: LocalizableStrings) -> String? {
        let string = NSLocalizedString(self, tableName: localizableStrings.tableName, value: "", comment: "")
        return string == self ? nil : string
    }

    private func localized() -> String {
        return NSLocalizedString(self, tableName: "Default", value: "", comment: "")
    }

}
