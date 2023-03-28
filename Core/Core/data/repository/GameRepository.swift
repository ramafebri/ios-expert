import Combine

class GameRepository: GameRepositoryProtocol {
    private let remoteSource: GameRemoteSourceProtocol
    private let localSource: LocalSourceProtocol
    
    init(remoteSource: GameRemoteSourceProtocol, localSource: LocalSourceProtocol) {
        self.remoteSource = remoteSource
        self.localSource = localSource
    }
    
    func getGamesList() -> AnyPublisher<[ItemGameModel], Error> {
        return remoteSource.getGamesList()
            .map { GameMapper.mapGameListResponseToModel(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getGameById(gameId: String) -> AnyPublisher<GameDetailModel, Error> {
        return remoteSource.getGameById(gameId: gameId)
            .map { GameMapper.mapGameDetailResponseToModel(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getAllFavorite(completion: @escaping ([ItemGameModel]) -> Void) {
        localSource.getAllFavorite { entity in
            completion(GameMapper.mapGameEntityListToModel(input: entity))
        }
    }
    
    func getFavoriteById(_ id: Int, completion: @escaping (ItemGameModel?) -> Void) {
        localSource.getFavoriteById(id, completion: { entity in
            completion(GameMapper.mapGameEntityToModel(input: entity))
        })
    }
    
    func createFavorite(_ gameId: Int, _ name: String, _ released: String, _ backgroundImage: String, _ rating: Double, completion: @escaping (Bool) -> Void) {
        localSource.createFavorite(gameId, name, released, backgroundImage, rating, completion: { isSuccess in
            completion(isSuccess)
        })
    }
    
    func deleteFavorite(_ id: Int, completion: @escaping (Bool) -> Void) {
        localSource.deleteFavorite(id, completion: { isSuccess in
            completion(isSuccess)
        })
    }
}
