import Combine

protocol GameRepositoryProtocol: AnyObject {
    func getGamesList() -> AnyPublisher<[ItemGameModel], Error>
    func getGameById(gameId: String) -> AnyPublisher<GameDetailModel, Error>
    func getAllFavorite(completion: @escaping(_ favorites: [ItemGameModel]) -> Void)
    func getFavoriteById(_ id: Int, completion: @escaping(_ favorite: ItemGameModel?) -> Void)
    func createFavorite(
        _ gameId: Int,
        _ name: String,
        _ released: String,
        _ backgroundImage: String,
        _ rating: Double,
        completion: @escaping(_ isSuccess: Bool) -> Void
    )
    func deleteFavorite(_ id: Int, completion: @escaping(_ isSuccess: Bool) -> Void)
}
