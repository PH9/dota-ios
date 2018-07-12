import XCTest
import OHHTTPStubs
@testable import dota

class HeroPresenterTests: XCTestCase {

    class SpyHeroPresenterProtocol: HeroesPresenterProtocol {

        var successExpectation: XCTestExpectation?
        func heroes(didFinishedWithSuccess heroes: [Hero]) {
            guard let expectation = successExpectation else {
                XCTFail("Should set successExpectation")
                return
            }

            expectation.fulfill()
            XCTAssertEqual(heroes.count, 2)
        }

        var errorExpectation: XCTestExpectation?
        func heroes(didFinishedWithError error: Error) {
            guard let expectation = errorExpectation else {
                XCTFail("Should set errorExpectation")
                return
            }

            expectation.fulfill()
        }
    }

    func test_GetHero_success() {
        let condition: OHHTTPStubsTestBlock = isHost("api.opendota.com")
            && isPath("/api/heroes")
            && isMethodGET()
        stub(condition: condition) { request -> OHHTTPStubsResponse in
            let stubPath = OHPathForFile("Heroes.json", type(of: self))!
            return OHHTTPStubsResponse(fileAtPath: stubPath,
                                       statusCode: 200,
                                       headers:["Content-Type":"application/json"])
        }

        let expectation = self.expectation(description: "get heroes success should call didFisnishWithSuccess")
        let spyHeroProtocol = SpyHeroPresenterProtocol()
        spyHeroProtocol.successExpectation = expectation

        let presenter = HeroesPresenter()
        presenter.delegate = spyHeroProtocol
        presenter.getHeros()

        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_GetHero_withError() {
        let condition: OHHTTPStubsTestBlock = isHost("api.opendota.com")
            && isPath("/api/heroes")
            && isMethodGET()
        stub(condition: condition) { request -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: Data(), statusCode: 400, headers: [:])
        }

        let expectation = self.expectation(description: "get heroes error should call didFisnishWithError")
        let spyHeroProtocol = SpyHeroPresenterProtocol()
        spyHeroProtocol.errorExpectation = expectation

        let presenter = HeroesPresenter()
        presenter.delegate = spyHeroProtocol
        presenter.getHeros()

        waitForExpectations(timeout: 3, handler: nil)
    }
}
