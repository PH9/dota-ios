import ObjectMapper

// swiftlint:disable identifier_name
struct Hero: Decodable, ImmutableMappable {
    let id: Int
    let name: String
    let localized_name: String
    let primary_attr: Attribute
    let attack_type: AttackType
    let roles: [String]
    let legs: Int

    init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        localized_name = try map.value("localized_name")
        primary_attr = try map.value("primary_attr")
        attack_type = try map.value("attack_type")
        roles = try map.value("roles")
        legs = try map.value("legs")
    }

    enum Attribute: String, Decodable {
        case agi
        case str
        case int
    }

    enum AttackType: String, Decodable {
        case melee = "Melee"
        case ranged = "Ranged"
    }
}
