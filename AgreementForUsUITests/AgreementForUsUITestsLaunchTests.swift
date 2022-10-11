//
//  AgreementForUsUITestsLaunchTests.swift
//  AgreementForUsUITests
//
//  Created by 황원상 on 2022/10/07.
//

import XCTest

final class AgreementForUsUITestsLaunchTests: XCTestCase {
    
    override func setUp() async throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func testScreenshots() {

         let webViewsQuery = XCUIApplication().webViews.webViews.webViews
         snapshot("0Launch")
         
         webViewsQuery.staticTexts["Tour"].tap()
         snapshot("1Main")

     }

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
