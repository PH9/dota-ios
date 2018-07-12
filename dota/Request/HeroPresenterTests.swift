import XCTest
import OHHTTPStubs
@testable import dota

class HeroPresenterTests: XCTestCase {

    class MockRepsonseder: HeroesPresenterProtocol {

        var error: Error?
        var expectation: XCTestExpectation?

        func heroes(didFinishedWithSuccess heroes: [Hero]) {
            expectation?.fulfill()
            XCTAssertNotNil(heroes)
            XCTAssertEqual(heroes.count, 2)
        }

        func heroes(didFinishedWithError error: Error) {
            self.error = error
        }
    }

    func testGetHero() {
        let condition: OHHTTPStubsTestBlock = isHost("api.opendota.com")
            && isPath("/api/heroes")
            && isMethodGET()
        stub(condition: condition) { request -> OHHTTPStubsResponse in
            let stubPath = OHPathForFile("Heroes.json", type(of: self))!
            return OHHTTPStubsResponse(fileAtPath: stubPath, statusCode:200, headers:["Content-Type":"application/json"])
        }
        let expectation = self.expectation(description: "alamofire request expectation")
        let mockRepsonseder = MockRepsonseder()
        mockRepsonseder.expectation = expectation
        let presenter = HeroesPresenter()
        presenter.delegate = mockRepsonseder
        presenter.getHeros()

        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
