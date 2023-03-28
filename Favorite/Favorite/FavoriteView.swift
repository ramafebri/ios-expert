import SwiftUI
import Core

public struct FavoriteView<DetailDestination: View, ProfileDestination: View>: View {
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    let detailView: ((Int) -> DetailDestination)
    let profileView: (() -> ProfileDestination)
    
    public init(
        favoriteViewModel: FavoriteViewModel,
        detailView: @escaping ((Int) -> DetailDestination),
        profileView: @escaping (() -> ProfileDestination)
    ) {
        self.favoriteViewModel = favoriteViewModel
        self.detailView = detailView
        self.profileView = profileView
    }
    
    public var body: some View {
        NavigationView {
            if favoriteViewModel.favoriteList.isEmpty {
                Text("Oops, loos like there's no favorites...")
            } else {
                List(favoriteViewModel.favoriteList) { items in
                    NavigationLink {
                        self.detailView(items.id)
                    } label: {
                        ItemGameView(item: items)
                    }
                }
                .navigationTitle("Favorite List")
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        NavigationLink(destination: self.profileView()) {
                            Text("Profile")
                        }
                    }
                }
            }
        }
        .onAppear {
            favoriteViewModel.loadFavorites()
        }
        .onReceive(favoriteViewModel.$favoriteList, perform: { res in
            favoriteViewModel.loadFavorites()
        })
    }
}
