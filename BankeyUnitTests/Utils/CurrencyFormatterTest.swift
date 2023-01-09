//
//  CurrencyFormatterTest.swift
//  BankeyUnitTests
//
//  Created by Boris Ofon on 11/14/22.
//

import Foundation

import XCTest

@testable import Bankey

class Test: XCTestCase {
    
    var formatter:CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
        
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(123)
        XCTAssertEqual(result, "$123.00")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }
}
