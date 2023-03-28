import Foundation
import Alamofire

struct GameListResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [ItemResultResponse]

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

struct ItemResultResponse: Decodable, Identifiable {
    let id: Int
    let name, released: String
    let backgroundImage: String
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
    }
}
