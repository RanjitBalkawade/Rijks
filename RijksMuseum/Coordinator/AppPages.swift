//
//  Screens.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import SwiftUI

enum AppPages: Hashable {
    case main
    case articleDetails(id: String)
}

enum Sheet: String, Identifiable {
    case moreInfo
    
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case buy
    
    var id: String {
        self.rawValue
    }
}

extension Coordinator {
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
            case .main:
                MainView(
                    viewModel: MainViewModel(service: Factory.createArtCollectionGetService())
                )
            case .articleDetails(let id):
                ArtDetailsView(
                    viewModel: ArtDetailsViewModel(service: Factory.createArtGetService(), objectNumber: id)
                )
        }
    }
    
    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
            case .moreInfo: MoreInfoView()
        }
    }
    
    @ViewBuilder
    func buildCover(cover: FullScreenCover) -> some View {
        switch cover {
            case .buy: BuyView()
        }
    }
    
}
