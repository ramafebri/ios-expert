import Cleanse

public struct HomeViewModelComponent: RootComponent {
    public typealias Root = HomeViewModel
    
    public static func configureRoot(binder bind: ReceiptBinder<HomeViewModel>) -> BindingReceipt<HomeViewModel> {
        return bind.to(factory: HomeViewModel.init)
    }
    
    public static func configure(binder: Binder<Singleton>) {
        binder.include(module: LocalSourceModule.self)
    }
}

public struct DetailViewModelComponent: RootComponent {
    public typealias Root = DetailViewModel
    
    public static func configureRoot(binder bind: ReceiptBinder<DetailViewModel>) -> BindingReceipt<DetailViewModel> {
        return bind.to(factory: DetailViewModel.init)
    }
    
    public static func configure(binder: Binder<Singleton>) {
        binder.include(module: LocalSourceModule.self)
    }
}

public struct FavoriteViewModelComponent: RootComponent {
    public typealias Root = FavoriteViewModel
    
    public static func configureRoot(binder bind: ReceiptBinder<FavoriteViewModel>) -> BindingReceipt<FavoriteViewModel> {
        return bind.to(factory: FavoriteViewModel.init)
    }
    
    public static func configure(binder: Binder<Singleton>) {
        binder.include(module: LocalSourceModule.self)
    }
}
