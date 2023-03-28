import Cleanse

struct RepositoryModule: Module {
    static func configure(binder: Binder<Singleton>) {
      binder.include(module: UseCaseModule.self)
      binder
        .bind(GameRepositoryProtocol.self)
        .sharedInScope()
        .to(factory: GameRepository.init)
  }
}
