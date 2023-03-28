import Foundation
struct Constants {
    static let baseURL = "https://api.rawg.io/api/"
    static let id = "id"
    static let gameId = "gameId"
    static let name = "name"
    static let released = "released"
    static let backgroundImage = "backgroundImage"
    static let rating = "rating"
    static let tableName = "Favorite"
    static let databaseName = "FavoriteDataModel"
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle(identifier: "com.example.ios-expert.Core")?.path(forResource: "GameInfos", ofType: "plist") else {
                fatalError("Couldn't find file 'GameInfos.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'GameInfos.plist'.")
            }
            return value
        }
    }
    
    func getGamesListUrl() -> String {
        return Constants.baseURL + "games?key=" + apiKey
    }
    
    func getGamesDetailUrl(gameId: String) -> String {
        return Constants.baseURL + "games/" + gameId + "?key=" + apiKey
    }
}
