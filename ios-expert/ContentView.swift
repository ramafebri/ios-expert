import SwiftUI
import Cleanse
import Favorite
import Core
import Detail
import ProfilePackage

struct ContentView: View {
    let homeViewModel = try? ComponentFactory.of(HomeViewModelComponent.self).build(())
    let detailViewModel = try? ComponentFactory.of(DetailViewModelComponent.self).build(())
    let favoriteViewModel = try? ComponentFactory.of(FavoriteViewModelComponent.self).build(())
    
    var body: some View {
        TabView {
            HomeView(
                viewModel: self.homeViewModel!,
                detailView: { gameId in
                    DetailGameView(
                        viewModel: self.detailViewModel!,
                        favoriteViewModel: self.favoriteViewModel!,
                        id: String(gameId)
                    )
                },
                profileView: {
                    ProfileView()
                }
            )
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            FavoriteView(
                favoriteViewModel: self.favoriteViewModel!,
                detailView: { gameId in
                    DetailGameView(
                        viewModel: self.detailViewModel!,
                        favoriteViewModel: self.favoriteViewModel!,
                        id: String(gameId)
                    )
                },
                profileView: {
                    ProfileView()
                }
            )
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorite")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
