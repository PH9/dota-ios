import Foundation

extension Decodable {
    static func decode(from dict: Any) throws -> Self {
        let data = try JSONSerialization.data(withJSONObject: dict, options: [])
        return try JSONDecoder().decode(self, from: data)
    }
}

func decode<T: Decodable>(JSON: Any, type: T.Type) throws -> T {
    return try type.decode(from: JSON)
}
