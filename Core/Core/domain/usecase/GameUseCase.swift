import Combine

class GameUseCase: GameUseCaseProtocol {
    private let repository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.repository = gameRepository
    }
    
    func getGamesList() -> AnyPublisher<[ItemGameModel], Error> {
        return repository.getGamesList()
    }
    
    func getGameById(gameId: String) -> AnyPublisher<GameDetailModel, Error> {
        return repository.getGameById(gameId: gameId)
    }
    
    func getAllFavorite(completion: @escaping ([ItemGameModel]) -> Void) {
        repository.getAllFavorite(completion: { result in
            completion(result)
        })
    }
    
    func getFavoriteById(_ id: Int, completion: @escaping (ItemGameModel?) -> Void) {
        repository.getFavoriteById(id, completion: { result in
            completion(result)
        })
    }
    
    func createFavorite(_ gameId: Int, _ name: String, _ released: String, _ backgroundImage: String, _ rating: Double, completion: @escaping (Bool) -> Void) {
        repository.createFavorite(gameId, name, released, backgroundImage, rating, completion: { isSuccess in
            completion(isSuccess)
        })
    }
    
    func deleteFavorite(_ id: Int, completion: @escaping (Bool) -> Void) {
        repository.deleteFavorite(id, completion: { isSuccess in
            completion(isSuccess)
        })
    }
}
