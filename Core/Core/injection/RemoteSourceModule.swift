import Cleanse

struct RemoteSourceModule: Module {
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: RepositoryModule.self)
        binder
            .bind(GameRemoteSourceProtocol.self)
            .sharedInScope()
            .to(factory: GameRemoteSource.init)
    }
}
