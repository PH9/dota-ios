import Foundation

func json(from fileName: String) -> Any? {
    return Bundle(for: JSONFileReader.self).path(forResource: fileName, ofType: "json")
        .flatMap { URL(fileURLWithPath: $0) }
        .flatMap { try? Data(contentsOf: $0) }
        .flatMap(JSONObjectWithData)
}

private func JSONObjectWithData(fromData data: Data) -> Any? {
    return try? JSONSerialization.jsonObject(with: data, options: [])
}

private class JSONFileReader { }
