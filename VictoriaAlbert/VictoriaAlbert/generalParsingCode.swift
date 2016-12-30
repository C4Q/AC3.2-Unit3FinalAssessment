import Foundation

//protocol Parsing {
//    associatedtype Response
//    func parse(dictionary dict: [String: Any]) -> Object?
//}

//struct ObjectParser: Parsing {
    func picParse(_ dict: [String : Any]) -> Pic? {
        guard let objectData = dict["object"] as? [String: Any],
            let id = objectData["id"] as? String else { return nil }
        return Pic(id)
    }
//}
