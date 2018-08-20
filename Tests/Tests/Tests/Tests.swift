//
//  Tests.swift
//  Tests
//
//  Created by materik on 2018-08-20.
//

import XCTest

@testable import SyncLocalizations

class Tests: XCTestCase {
    
    func testLocalizable1() {
        XCTAssertEqual(TestStrings1.title.localized, "Hello")
        XCTAssertEqual(TestStrings1.description.localized, "This is a fun description")
    }
    
    func testLocalizable2() {
        XCTAssertEqual(TestStrings2.title.localized, "Howdy")
        XCTAssertEqual(TestStrings2.description.localized, "This is a duplicate")
    }
    
}

private enum TestStrings1: String, Localizable {
    
    case title
    case description
    
    var table: String {
        return "Localizable1"
    }
    
    var bundle: Bundle {
        return Bundle(for: Tests.self)
    }
    
}

private enum TestStrings2: String, Localizable {
    
    case title
    case description
    
    var table: String {
        return "Localizable2"
    }
    
    var bundle: Bundle {
        return Bundle(for: Tests.self)
    }
    
}
