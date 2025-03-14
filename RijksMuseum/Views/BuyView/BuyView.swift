//
//  BuyView.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import SwiftUI

struct BuyView: View {
    
    @Environment(Coordinator.self) private var coordinator
    @State private var viewModel = BuyViewModel()
    
    var body: some View {
        Button(viewModel.buyButtonTitle) {
            coordinator.dismissCover()
        }
    }
}
