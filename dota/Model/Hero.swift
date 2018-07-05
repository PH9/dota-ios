struct Hero {
    let id: Int
    let name: String
    let localizedName: String
    let primaryAttribute: Attribute
    let attackType: AttackType
    let roles: [String]
    let legs: Int

    init?(JSON: [String: Any]) {
        guard let id = JSON["id"] as? Int, id > 0 else {
            return nil
        }

        guard let name = JSON["name"] as? String, !name.isEmpty else {
            return nil
        }

        guard let localizedName = JSON["localized_name"] as? String else {
            return nil
        }

        guard let primaryAttributeString = JSON["primary_attr"] as? String,
            let primaryAttribute = Attribute(rawValue: primaryAttributeString) else {
                return nil
        }

        guard let attackTypeString = JSON["attack_type"] as? String,
            let attackType = AttackType(rawValue: attackTypeString) else {
                return nil
        }

        guard let roles = JSON["roles"] as? [String] else {
            return nil
        }

        guard let legs = JSON["legs"] as? Int else {
            return nil
        }

        self.id = id
        self.name = name
        self.localizedName = localizedName
        self.primaryAttribute = primaryAttribute
        self.attackType = attackType
        self.roles = roles
        self.legs = legs
    }

    enum Attribute: String {
        case agi
        case str
        case int
    }

    enum AttackType: String {
        case melee = "Melee"
        case ranged = "Ranged"
    }
}
