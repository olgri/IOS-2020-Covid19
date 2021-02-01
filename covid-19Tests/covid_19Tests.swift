//
//  covid_19Tests.swift
//  covid-19Tests
//
//  Created by Oleg Gribovsky on 26.01.21.
//

import XCTest

@testable import covid_19

class covid_19Tests: XCTestCase {
    
    var validator: ValidationService!

    override func setUpWithError() throws {
        validator = ValidationService()
    }

    override func tearDownWithError() throws {
        validator = nil
    }

    func testIfEmptyLoginFieldThenFalse() throws {
        do {
            try validator.validateUsername("")
            XCTAssertFalse(true)
        }
        catch {
            XCTAssertFalse(false)
        }
    }
    
    func testIfEmptyPasswordFieldThenTrue() throws {
        do {
            try validator.validatePassword("")
            XCTAssertFalse(true)
        }
        catch {
            XCTAssertFalse(false)
        }
    }
    
    func testIfLoginFieldLengthMoreThen3ChartsThenTrue() throws {
        do {
            try validator.validateUsername("333")
            XCTAssertFalse(false)
        }
        catch {
            XCTAssertFalse(false)
        }
    }

}
