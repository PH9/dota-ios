import XCTest
import OHHTTPStubs
@testable import dota

class HeroPresenterTests: XCTestCase {

    class SpyHeroPresenterProtocol: HeroesPresenterProtocol {

        var successExpectation: XCTestExpectation?
        func heroes(didFinishedWithSuccess heroes: [Hero]) {
            successExpectation?.fulfill()
            XCTAssertEqual(heroes.count, 2)
        }

        func heroes(didFinishedWithError error: Error) {
        }
    }

    func test_GetHero_success() {
        let condition: OHHTTPStubsTestBlock = isHost("api.opendota.com")
            && isPath("/api/heroes")
            && isMethodGET()
        stub(condition: condition) { request -> OHHTTPStubsResponse in
            let stubPath = OHPathForFile("Heroes.json", type(of: self))!
            return OHHTTPStubsResponse(fileAtPath: stubPath, statusCode:200, headers:["Content-Type":"application/json"])
        }

        let expectation = self.expectation(description: "alamofire request expectation")
        let spyHeroProtocol = SpyHeroPresenterProtocol()
        spyHeroProtocol.successExpectation = expectation

        let presenter = HeroesPresenter()
        presenter.delegate = spyHeroProtocol
        presenter.getHeros()

        waitForExpectations(timeout: 3, handler: nil)
    }
}
