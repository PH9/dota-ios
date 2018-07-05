// swiftlint:disable identifier_name
struct Hero: Decodable {
    let id: Int
    let name: String
    let localized_name: String
    let primary_attr: Attribute
    let attack_type: AttackType
    let roles: [String]
    let legs: Int

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
