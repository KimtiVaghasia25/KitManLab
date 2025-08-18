//
//  AtheletsSectionLazyStackView.swift
//  
//
//  Created by Kimti Vaghasia on 14/07/2025.
//

import SwiftUI

struct AtheletsSectionLazyStackView<ViewModel>: View where ViewModel: AthleteListViewModel {
    
    @ObservedObject var viewModel : ViewModel

    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                RefreshableScrollView(onRefresh: { done in
                    viewModel.refreshOnPull{ _,_  in
                        done()
                    }
                }, progress: { state in
                    if state == .loading {
                        VStack(spacing:5) {
                                RefreshActivityIndicator(isAnimating: true)
                                Text("Refreshing")
                                    .font(Font(StyleManager.lightApplicationFont(size: AppFontSize.subtitle)))
                        }
                    }
                }) {
                    
                    if #available(iOS 14.0, *) {
                        LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                            
                            ForEach(viewModel.sectionedList) { section in
                                Section(header: ListHeader(headerText: section.displayValue.uppercased(), leading: Padding.edgeMax))
                                {

                                    ForEach(section.items, id: \.id) { atheleteObj in
                                        VStack {
                                            AthleteListItemView(viewModel: viewModel,
                                                                athleteObj: atheleteObj as! AthleteListResultObject,
                                                                preferredMaxLayoutWidth: geometry.size.width - AppSize.Margin.width)
                                        }
                                        .padding(.leading, Padding.edgeMax)
                                        .background(Color(UIColor.white))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
        }
        .contentShape(Rectangle())
        .frame(maxWidth:.infinity)
    }
}

struct AtheletsSectionLazyStackView_Previews: PreviewProvider {
    
    static var previews: some View {
        AtheletsSectionLazyStackView(viewModel: getModel())
    }

    
    
    static func getModel() -> AthleteListViewModel {
        let viewModel = AthleteListViewModel()
        viewModel.state = .loaded
     
        let athleteObj = AthleteListResultsSectionData(key: "My name", displayValue: "Athlete",
                                                       items: [getAthelete(), getAthelete()])
        viewModel.sectionedList.append(athleteObj)
        return viewModel
    }
    
    static func getAthelete() -> AthleteListResultObject {
        let image = AthleteImage(url: "https://kitman.imgix.net/avatar.jpg")
        let athlete = Athlete(firstName: "Kim", lastName: "Vaghasia", userName: "KimVag", athleteImage: image)
        
        return AthleteListResultObject(athlete: athlete)

    }
}
