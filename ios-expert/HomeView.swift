import SwiftUI
import Core

struct HomeView<DetailDestination: View, ProfileDestination: View>: View {
    @ObservedObject var viewModel: HomeViewModel
    let detailView: ((Int) -> DetailDestination)
    let profileView: (() -> ProfileDestination)
    
    public init(
        viewModel: HomeViewModel,
        detailView: @escaping ((Int) -> DetailDestination),
        profileView: @escaping (() -> ProfileDestination)
    ) {
        self.viewModel = viewModel
        self.detailView = detailView
        self.profileView = profileView
    }
    
    var body: some View {
        NavigationView {
            if (viewModel.loadingState == true) {
                ProgressView("Fetching data")
            } else {
                List(viewModel.gamesList) { items in
                    NavigationLink {
                        self.detailView(items.id)
                    } label: {
                        ItemGameView(item: items)
                    }
                }
                .navigationTitle("Games List")
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
            viewModel.getGamesData()
        }
    }
}
