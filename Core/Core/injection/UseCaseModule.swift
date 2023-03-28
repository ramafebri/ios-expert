import Cleanse

struct UseCaseModule: Module {
    static func configure(binder: Binder<Singleton>) {
    binder
      .bind(GameUseCaseProtocol.self)
      .sharedInScope()
      .to(factory: GameUseCase.init)
  }
}
