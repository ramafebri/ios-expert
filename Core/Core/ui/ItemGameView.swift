import SwiftUI

public struct ItemGameView: View {
    var item: ItemGameModel
    
    public init(item: ItemGameModel) {
        self.item = item
    }
    
    public var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.backgroundImage))
            { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 100, height: 100)
            VStack {
                Text(item.name)
                    .multilineTextAlignment(.leading)
                Text(item.released)
                Text(String(item.rating))
            }.padding([.leading], 10)
        }
    }
}
