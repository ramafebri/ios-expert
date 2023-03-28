import Cleanse

public struct LocalSourceModule: Module {
    public static func configure(binder: Binder<Singleton>) {
        binder.include(module: RemoteSourceModule.self)
        binder
            .bind(LocalSourceProtocol.self)
            .sharedInScope()
            .to(factory: LocalSource.init)
    }
}
