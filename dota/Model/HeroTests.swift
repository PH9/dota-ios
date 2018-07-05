import XCTest
@testable import dota

// swiftlint:disable force_cast
class HeroTests: XCTestCase {
    func testHero() {
        let dummyHero = Hero(JSON: json(from: "HeroTests") as! [String: Any])

        XCTAssertEqual(1, dummyHero?.id)
        XCTAssertEqual("npc_dota_hero_antimage", dummyHero?.name)
        XCTAssertEqual("Anti-Mage", dummyHero?.localizedName)
        XCTAssertEqual(Hero.Attribute.agi, dummyHero?.primaryAttribute)
        XCTAssertEqual(Hero.AttackType.melee, dummyHero?.attackType)

        let expectedRoles = ["Carry", "Escape", "Nuker"]
        XCTAssertEqual(expectedRoles, dummyHero?.roles)
        XCTAssertEqual(2, dummyHero?.legs)
    }
}
