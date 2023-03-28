public struct GameDetailModel {
    public var id: Int = 0
    public var name: String = ""
    public var descriptionRaw: String = ""
    public var released: String = ""
    public var backgroundImage: String = ""
    public var rating: Double = 0.0
    public var genres: [GameGenreModel]? = nil
}

public struct GameGenreModel {
    let id: Int
    let name: String?
}
