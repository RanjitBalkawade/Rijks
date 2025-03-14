//
//  MainViewSnapshotTests.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/08/2024.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable
import RijksMuseum

class MainViewSnapshotTests: XCTestCase {
    
    @MainActor
    func test_MainViewSuccessState() async {
        let mockService = MockArtCollectionGetService()
        
        mockService.artCollectionHandler = { _ in
            ArtFixtures.getArtCollection()
        }
    
        let mainViewModel = MainViewModel(service: mockService)
        let view = MainView(viewModel: mainViewModel).environment(Coordinator())
        let viewController = UIHostingController(rootView: view)
        
        await mainViewModel.loadData(with: "")
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
    
    @MainActor
    func test_MainViewFailureState() async {
        let mockService = MockArtCollectionGetService()
        
        mockService.getCollectionShouldReturnError = true
        let mainViewModel = MainViewModel(service: mockService)
        let view = MainView(viewModel: mainViewModel).environment(Coordinator())
        let viewController = UIHostingController(rootView: view)
        
        await mainViewModel.loadData(with: "")
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
    

    func test_MainViewLoadingState()  {
        let mockService = MockArtCollectionGetService()
        
        let mainViewModel = MainViewModel(service: mockService)
        let view = MainView(viewModel: mainViewModel).environment(Coordinator())
        let viewController = UIHostingController(rootView: view)
        
        mockService.artCollectionHandler = { _ in
            return ArtFixtures.getArtCollection()
        }
        
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
}
