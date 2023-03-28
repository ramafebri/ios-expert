import Combine
import Foundation

public class HomeViewModel: ObservableObject {
    @Published public var gamesList = [ItemGameModel]()
    @Published public var errorMessage: String = ""
    @Published public var loadingState: Bool = true
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: GameUseCaseProtocol
    
    init(gameUseCase: GameUseCaseProtocol) {
      self.useCase = gameUseCase
    }
    
    public func getGamesData() {
        useCase.getGamesList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
              switch completion {
              case .failure:
                self.errorMessage = String(describing: completion)
              case .finished:
                self.loadingState = false
              }
            }, receiveValue: { response in
                self.gamesList = response
            })
            .store(in: &cancellables)
    }
}
