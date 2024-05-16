import XCTest
import OSLog
import Foundation
@testable import TheShopCore

let logger: Logger = Logger(subsystem: "TheShopCore", category: "Tests")

@available(macOS 13, *)
final class TheShopCoreTests: XCTestCase {
    func testTheShopCore() throws {
        logger.log("running testTheShopCore")
        XCTAssertEqual(1 + 2, 3, "basic test")
        
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("TheShopCore", testData.testModuleName)
    }
}

struct TestData : Codable, Hashable {
    var testModuleName: String
}