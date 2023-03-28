final class GameMapper {
    
    static func mapGameListResponseToModel(
        input response: GameListResponse
    ) -> [ItemGameModel] {
        return response.results.map { result in
            let model = ItemGameModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating
            )
            return model
        }
    }
    
    static func mapGameResultResponseToModel(
        input response: [ItemResultResponse]
    ) -> [ItemGameModel] {
        return response.map { result in
            let model = ItemGameModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating
            )
            return model
        }
    }
    
    static func mapGameDetailResponseToModel(
        input response: GameDetailResponse
    ) -> GameDetailModel {
        return GameDetailModel(
            id: response.id,
            name: response.name,
            descriptionRaw: response.descriptionRaw,
            released: response.released,
            backgroundImage: response.backgroundImage,
            rating: response.rating,
            genres: response.genres?.map { result in
                GameGenreModel(id: result.id, name: result.name)
            }
        )
    }
    
    static func mapGameEntityListToModel(
        input entity: [ItemGameEntity]
    ) -> [ItemGameModel] {
        return entity.map { result in
            let model = ItemGameModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating
            )
            return model
        }
    }
    
    static func mapGameEntityToModel(
        input entity: ItemGameEntity?
    ) -> ItemGameModel {
        return ItemGameModel(
            id: entity?.id ?? 0,
            name: entity?.name ?? "",
            released: entity?.released ?? "",
            backgroundImage: entity?.backgroundImage ?? "",
            rating: entity?.rating ?? 0.0
        )
    }
}
