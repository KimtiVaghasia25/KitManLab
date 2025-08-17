//
//  AtheletsDetailView.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//
import SwiftUI

struct AtheletsDetailView<ViewModel>: View where ViewModel: SquadListViewModel {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
    
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.fetchSquads)

        case .loading:
            ListLoadingView(loadingStatus: "Loading...", loadingDescription: "")
            
        case .loaded:
            SquadListView(viewModel: viewModel)
            
        case .failed(_):
            ListErrorView(error: NSError(domain: "", code: 0, userInfo: [
                NSLocalizedDescriptionKey: "There was an error loading list."]), retryAction: { })
            
        }
        
    }
}

struct SquadListView<ViewModel>: View where ViewModel: SquadListViewModel {
    @ObservedObject var viewModel : ViewModel

    var body: some View {
        List(viewModel.squadResultObjects) { sqdObj in
            if let name = sqdObj.squad.name {
                AttributedText()
                {
                    $0.font = StyleManager.boldApplicationFont(size: AppFontSize.title)
                    $0.textColor = AppColor.labelGrey
                    $0.numberOfLines = 0
                    $0.lineBreakMode = .byWordWrapping
                    $0.attributedText = NSMutableAttributedString(string: name)
                }
            }
            if let createdDate = sqdObj.squad.createdDate, let date = createdDate.toDate() {
                Text("Created date : \( StyleManager.apiDateFormatter.string(from: date))")
            }
            
            if let updatedDate = sqdObj.squad.updatedDate, let date = updatedDate.toDate() {
                Text("Updated date : \( StyleManager.apiDateFormatter.string(from: date))")
            }
        }
    }
}
