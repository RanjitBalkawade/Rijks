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
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                artworkImage
                contentDetails
            }
            Divider()
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            if let id = viewModel.objectNumber {
                coordinator.push(page: .articleDetails(id: id))
            }
        }
    }

    private var artworkImage: some View {
        Group {
            if let imageUrl = viewModel.imageUrl, let url = URL(string: imageUrl) {
                KFImage(url)
                    .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 80, height: 100)))
                    .cacheOriginalImage()
                    .fade(duration: 0.25)
                    .resizable()
            } else {
                Image(viewModel.placeHolderImageName)
                    .resizable()
            }
        }
        .scaledToFit()
        .frame(width: 80, height: 100)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
    
    private var contentDetails: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            HStack(spacing: 12) {
                Button(viewModel.buyButtonTitle) {
                    coordinator.presentFullScreenCover(.buy)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)

                Button(viewModel.moreInfoButtonTitle) {
                    coordinator.presentSheet(.moreInfo)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ArtCollectionThumbnailView(viewModel: ArtCollectionThumbnailViewModel(article: ArtFixtures.art)).environment(Coordinator())
}
