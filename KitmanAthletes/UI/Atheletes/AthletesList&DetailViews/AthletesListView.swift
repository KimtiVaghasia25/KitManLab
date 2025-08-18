//
//  AthletesListView.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//

import SwiftUI
import Foundation

struct AthletesListView<ViewModel>: View where ViewModel: AthleteListViewModel {
    
    @ObservedObject var athleteListViewModel : ViewModel

    init(athleteListViewModel: ViewModel) {
        self.athleteListViewModel = athleteListViewModel
    }
    
    var body: some View {
    
        switch athleteListViewModel.state {
        case .idle:
            Color.clear.onAppear(perform: athleteListViewModel.fetchAthletes)

        case .loading:
            ListLoadingView(loadingStatus: "Loading...", loadingDescription: "")
            
        case .loaded:
            NavigationStack {
                Text("Searching for \(athleteListViewModel.searchText)")
                    .searchable(text: $athleteListViewModel.searchText, prompt: "Look for something")
                   }
            AtheletsSectionLazyStackView(viewModel: athleteListViewModel)
          
        case .failed(_):
            ListErrorView(error: NSError(domain: "", code: 0, userInfo: [
                NSLocalizedDescriptionKey: "There was an error loading list."]), retryAction: { })
            
        }
        
    }
}

struct ListHeader: View {
    
    var headerText:String
    var leading = 15.0
    
    var body: some View {
        HStack {
            Text(headerText)
                .padding(.leading, leading)
                .padding([.top, .bottom], Padding.edgeMin)
                .font(.system(size: AppFontSize.subtitle, weight:.bold))
                .foregroundColor(Color(UIColor.gray))
            Spacer()
        }
        .frame(minHeight: AppSize.headerHeight)
        .background(AppColor.headerbackgroundColor)
    }
}



