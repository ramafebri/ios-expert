import Combine
import Foundation

public class FavoriteViewModel: ObservableObject {
    @Published public var favoriteList: [ItemGameModel] = []
    @Published public var isFavorite: Bool = false
    private let useCase: GameUseCaseProtocol
    
    init(gameUseCase: GameUseCaseProtocol) {
        self.useCase = gameUseCase
    }
    
    public func loadFavorites() {
        self.useCase.getAllFavorite { result in
            DispatchQueue.main.async {
                self.favoriteList = result
            }
        }
    }
    
    public func saveToFavorite(
        gameId: Int,
        name: String,
        released: String,
        backgroundImage: String,
        rating: Double
    ) {
        self.useCase.createFavorite(gameId, name, released, backgroundImage, rating, completion: { isSuccess in
            self.isFavorite = isSuccess
        })
    }
    
    public func getFavoriteById(gameId: Int) {
        self.useCase.getFavoriteById(gameId, completion: { res in
            DispatchQueue.main.async {
                if let data = res {
                    self.isFavorite = data.name != ""
                }
            }
        })
    }
    
    public func deleteFavoriteById(gameId: Int) {
        self.useCase.deleteFavorite(gameId, completion: { isSuccess in
            DispatchQueue.main.async {
                self.isFavorite = !isSuccess
            }
        })
    }
}
