import Alamofire
import Combine

public class DetailViewModel: ObservableObject {
    @Published public var gamesDetail = GameDetailModel()
    @Published public var firstGenre = ""
    @Published public var secondGenre = ""
    @Published public var errorMessage: String = ""
    @Published public var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: GameUseCaseProtocol
    
    init(gameUseCase: GameUseCaseProtocol) {
      self.useCase = gameUseCase
    }
    
    public func getGamesDetail(id: String) {
        useCase.getGameById(gameId: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
              switch completion {
              case .failure:
                self.errorMessage = String(describing: completion)
              case .finished:
                self.loadingState = false
              }
            }, receiveValue: { response in
                self.gamesDetail = response
                if let genres = self.gamesDetail.genres {
                    for (index, genre) in genres.enumerated() {
                        if (index == 0) {
                            self.firstGenre = genre.name ?? ""
                        }
                        if (index == 1) {
                            self.secondGenre = genre.name ?? ""
                        }
                    }
                }
            })
            .store(in: &cancellables)
    }
}
