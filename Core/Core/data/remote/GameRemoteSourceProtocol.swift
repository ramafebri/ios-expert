import Combine

protocol GameRemoteSourceProtocol: AnyObject {
    func getGamesList() -> AnyPublisher<GameListResponse, Error>
    func getGameById(gameId: String) -> AnyPublisher<GameDetailResponse, Error>
}
