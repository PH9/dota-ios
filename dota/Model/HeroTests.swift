import XCTest
@testable import dota
import ObjectMapper

// swiftlint:disable force_try
class HeroTests: XCTestCase {
    func testHero_fromDecodable() {
        let dict = json(from: "HeroTests")!
        let hero = try! Hero.decode(from: dict)

        XCTAssertEqual(1, hero.id)
        XCTAssertEqual("npc_dota_hero_antimage", hero.name)
        XCTAssertEqual("Anti-Mage", hero.localized_name)
        XCTAssertEqual(Hero.Attribute.agi, hero.primary_attr)
        XCTAssertEqual(Hero.AttackType.melee, hero.attack_type)

        let expectedRoles = ["Carry", "Escape", "Nuker"]
        XCTAssertEqual(expectedRoles, hero.roles)
        XCTAssertEqual(2, hero.legs)
    }

    func testHero_fromDecodableFunc() {
        let dict = json(from: "HeroTests")!
        let hero = try! decode(JSON: dict, type: Hero.self)

        XCTAssertEqual(1, hero.id)
        XCTAssertEqual("npc_dota_hero_antimage", hero.name)
        XCTAssertEqual("Anti-Mage", hero.localized_name)
        XCTAssertEqual(Hero.Attribute.agi, hero.primary_attr)
        XCTAssertEqual(Hero.AttackType.melee, hero.attack_type)

        let expectedRoles = ["Carry", "Escape", "Nuker"]
        XCTAssertEqual(expectedRoles, hero.roles)
        XCTAssertEqual(2, hero.legs)
    }

    func testHero_fromObjectMapper() {
        let dict = json(from: "HeroTests")!
        let hero = try! Hero(JSONObject: dict)

        XCTAssertEqual(1, hero.id)
        XCTAssertEqual("npc_dota_hero_antimage", hero.name)
        XCTAssertEqual("Anti-Mage", hero.localized_name)
        XCTAssertEqual(Hero.Attribute.agi, hero.primary_attr)
        XCTAssertEqual(Hero.AttackType.melee, hero.attack_type)

        let expectedRoles = ["Carry", "Escape", "Nuker"]
        XCTAssertEqual(expectedRoles, hero.roles)
        XCTAssertEqual(2, hero.legs)
    }
}
