struct Hero: Decodable {
    let id: Int
    let name: String
    let localizedName: String
    let primaryAttribute: Attribute
    let attackType: AttackType
    let roles: [String]
    let legs: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case localizedName = "localized_name"
        case primaryAttribute = "primary_attr"
        case attackType = "attack_type"
        case roles
        case legs
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        localizedName = try values.decode(String.self, forKey: .localizedName)
        primaryAttribute = try values.decode(Attribute.self, forKey: .primaryAttribute)
        attackType = try values.decode(AttackType.self, forKey: .attackType)
        roles = try values.decode([String].self, forKey: .roles)
        legs = try values.decode(Int.self, forKey: .legs)
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
