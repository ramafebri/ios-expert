struct GameDetailResponse: Decodable {
    var id: Int = 0
    var name: String = ""
    var descriptionRaw: String = ""
    var released: String = ""
    var backgroundImage: String = ""
    var rating: Double = 0.0
    var genres: [GenreResponse]? = nil

    enum CodingKeys: String, CodingKey {
        case id, name
        case descriptionRaw = "description_raw"
        case released
        case backgroundImage = "background_image"
        case rating
        case genres
    }
}

struct GenreResponse: Decodable {
    let id: Int
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
