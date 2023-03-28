import SwiftUI
import AlertToast
import Core

public struct DetailGameView: View {
    @ObservedObject var viewModel: DetailViewModel
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    @State private var showToast = false
    var id: String
    public init(
        viewModel: DetailViewModel,
        favoriteViewModel: FavoriteViewModel,
        showToast: Bool = false,
        id: String
    ) {
        self.viewModel = viewModel
        self.favoriteViewModel = favoriteViewModel
        self.showToast = showToast
        self.id = id
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: viewModel.gamesDetail.backgroundImage))
                { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 300, height: 200)
                
                VStack(alignment: .leading) {
                    Text(viewModel.gamesDetail.name)
                        .font(.title)
                    
                    HStack {
                        Text(viewModel.gamesDetail.released)
                        Spacer()
                        Text("\(viewModel.gamesDetail.rating)")
                        Button(action: {
                            if(viewModel.gamesDetail.name.isEmpty) {
                                showToast.toggle()
                            } else {
                                if (favoriteViewModel.isFavorite) {
                                    favoriteViewModel.deleteFavoriteById(
                                        gameId: viewModel.gamesDetail.id
                                    )
                                } else {
                                    favoriteViewModel.saveToFavorite(
                                        gameId: viewModel.gamesDetail.id,
                                        name: viewModel.gamesDetail.name,
                                        released: viewModel.gamesDetail.released,
                                        backgroundImage: viewModel.gamesDetail.backgroundImage,
                                        rating: viewModel.gamesDetail.rating
                                    )
                                }
                            }
                        }) {
                            if (favoriteViewModel.isFavorite) {
                                Image(systemName: "heart.fill")
                            } else {
                                Image(systemName: "heart")
                            }
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    ScrollView(.horizontal) {
                        LazyHStack() {
                            Text(viewModel.firstGenre)
                            Text(viewModel.secondGenre)
                        }
                    }
                    
                    Divider()
                    
                    Text("Description")
                        .font(.title2)
                    Text(viewModel.gamesDetail.descriptionRaw)
                }
                .onAppear() {
                    viewModel.getGamesDetail(id: id)
                    favoriteViewModel.getFavoriteById(gameId: Int(id) ?? 0)
                }
                .padding()
                
                Spacer()
            }
            .toast(isPresenting: $showToast){
                AlertToast(type: .regular, title: "Data is not loaded yet")
            }
        }
    }
}
