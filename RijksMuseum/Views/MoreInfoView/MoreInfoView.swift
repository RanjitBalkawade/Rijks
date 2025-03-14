//
//  MoreInfoView.swift
//  RijksMuseum
//
//  Created by Ranjeet Balkawade on 13/03/2025.
//

import SwiftUI

struct MoreInfoView: View {
    
    @Environment(Coordinator.self) private var coordinator
    @State private var viewModel = MoreInfoViewModel()
    
    var body: some View {
        Button(viewModel.cancelButtonTitle) {
            coordinator.dismissSheet()
        }
    }
    
}
