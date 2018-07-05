import XCTest
@testable import dota

// swiftlint:disable force_try
class HeroTests: XCTestCase {
    func testHero_fromDecodable() {
        let dict = json(from: "HeroTests")!
        let heroData = try! JSONSerialization.data(withJSONObject: dict, options: [])
        let docoder = JSONDecoder()
        let hero = try! docoder.decode(Hero.self, from: heroData)

        XCTAssertEqual(1, hero.id)
        XCTAssertEqual("npc_dota_hero_antimage", hero.name)
        XCTAssertEqual("Anti-Mage", hero.localizedName)
        XCTAssertEqual(Hero.Attribute.agi, hero.primaryAttribute)
        XCTAssertEqual(Hero.AttackType.melee, hero.attackType)

        let expectedRoles = ["Carry", "Escape", "Nuker"]
        XCTAssertEqual(expectedRoles, hero.roles)
        XCTAssertEqual(2, hero.legs)
    }
}
