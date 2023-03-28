protocol LocalSourceProtocol: AnyObject {
    func getAllFavorite(completion: @escaping(_ favorites: [ItemGameEntity]) -> Void)
    func getFavoriteById(_ id: Int, completion: @escaping(_ favorite: ItemGameEntity?) -> Void)
    func createFavorite(
        _ gameId: Int,
        _ name: String,
        _ released: String,
        _ backgroundImage: String,
        _ rating: Double,
        completion: @escaping(_ isSuccess: Bool) -> Void
    )
    func getMaxId(completion: @escaping(_ maxId: Int) -> Void)
    func deleteFavorite(_ id: Int, completion: @escaping(_ isSuccess: Bool) -> Void)
}
