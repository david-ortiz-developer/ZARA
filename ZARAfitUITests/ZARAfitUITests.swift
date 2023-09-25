//
//  ZARAfitUITests.swift
//  ZARAfitUITests
//
//  Created by Davit on 22/09/23.
//

import XCTest

final class ZARAfitUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfAlexanderIsDead() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let tablesQuery = app.tables
        _ = app.staticTexts["Rick Sanchez"].waitForExistence(timeout: 5)
        tablesQuery.cells.containing(.staticText,
                                     identifier:
                                        "Rick Sanchez").children(matching:
                                                .other).element(boundBy: 2).swipeUp()
        tablesQuery.cells.containing(.staticText,
                                     identifier:
                                        "Abadango Cluster Princess").children(matching:
                                                .other).element(boundBy: 0).swipeUp()
        tablesQuery.cells.containing(.staticText,
                                     identifier:
                                        "Alan Rails").children(matching:
                                                .other).element(boundBy: 2).swipeUp()
        app.staticTexts["Alexander"].tap()
        XCTAssert(app.staticTexts["Dead"].exists)
    }
    func testCryingMortyEmptyTable() throws {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["ZARAfit.CharactersListView"].searchFields["Filter Characters"].tap()
        let xCapsKey = app.keyboards.keys["X"]
        xCapsKey.tap()
        let xKey = app.keyboards.keys["x"]
        xKey.tap()
        XCTAssert(
            app.tables.staticTexts["No results"].exists
        )
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
