//
//  covid_19Tests.swift
//  covid-19Tests
//
//  Created by Oleg Gribovsky on 26.01.21.
//

import XCTest

@testable import covid_19

class covid_19Tests: XCTestCase {
    
    var validator: LoginViewController!

    override func setUpWithError() throws {
        validator = LoginViewController()
    }

    override func tearDownWithError() throws {
        validator = nil
    }

    func testThatOnEmptyFieladsThen() throws {
        let result = validator.isLoginCheckPass(loginText: "", passwordText: "")
        XCTAssertFalse(result)
    }
    
    func testThatLoginFilledAndPasswordNotFilled() {
        let result = validator.isLoginCheckPass(loginText: "123456", passwordText: "")
        XCTAssertFalse(result)
    }
    
    func testThatLoginNotFilledAndPasswordFilled() {
        let result = validator.isLoginCheckPass(loginText: "", passwordText: "123456")
        XCTAssertFalse(result)
    }
    
    func testThatPasswordMoreThan6Characters() {
        let result = validator.isLoginCheckPass(loginText: "123456", passwordText: "12345")
        XCTAssertFalse(result)
    }
    
    func testThatUserEnterWrongPasswordMoreThan5Times(){
        var validSum: Int = 0
        for _ in 1...5 {
            let result = validator.isLoginCheckPass(loginText: "", passwordText: "")
            if !result {
                validSum+=1
            }
        }
        let result = validator.isLoginCheckPass(loginText: "123456", passwordText: "123456")
       
        XCTAssertFalse((validSum == 5) && result)
        
    }

}
