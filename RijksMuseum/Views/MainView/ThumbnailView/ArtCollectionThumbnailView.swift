//
//  ArtCollectionThumbnailView.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import SwiftUI
import Kingfisher

struct ArtCollectionThumbnailView: View {
    
    @Environment(Coordinator.self) private var coordinator
    let viewModel: ArtCollectionThumbnailViewModel
    
    var body: some View {
        VStack {
            HStack {
                if let imageUrl = viewModel.imageUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 100)
                } else {
                    Image(viewModel.placeHolderImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 100)
                }
                VStack {
                    Text(viewModel.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Button(viewModel.buyButtonTitle) {
                            coordinator.presentFullScreenCover(.buy)
                        }
                        Button(viewModel.moreInfoButtonTitle) {
                            coordinator.presentSheet(.moreInfo)
                        }
                        Spacer()
                    }
                }
            }
            Divider()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if let id = viewModel.objectNumber {
                coordinator.push(page: .articleDetails(id: id))
            }
        }
    }
}

#Preview {
    ArtCollectionThumbnailView(viewModel: ArtCollectionThumbnailViewModel(article: ArtFixtures.art)).environment(Coordinator())
}
