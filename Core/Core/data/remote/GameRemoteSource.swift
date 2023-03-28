import Alamofire
import Combine

class GameRemoteSource: GameRemoteSourceProtocol {
    
    func getGamesList() -> AnyPublisher<GameListResponse, Error> {
        return Future<GameListResponse, Error> { completion in
            if let url = URL(string: Constants().getGamesListUrl()) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameListResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.self))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameById(gameId: String) -> AnyPublisher<GameDetailResponse, Error> {
        return Future<GameDetailResponse, Error> { completion in
            if let url = URL(string: Constants().getGamesDetailUrl(gameId: gameId)) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.self))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
