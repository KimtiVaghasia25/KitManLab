//
//  PatientListItemView.swift
//  LoadPatients
//
//  Created by Kimti Vaghasia on 14/07/2025.
//
import SwiftUI

struct AthleteListItemView<ViewModel> : View where ViewModel: AthleteListViewModel {
    
    @ObservedObject var viewModel : ViewModel
    @ObservedObject var athleteObj: AthleteListResultObject
    var preferredMaxLayoutWidth: CGFloat
    
    @State var shouldNavigate:Bool = false
    
    var body: some View {
        ZStack{
           
            NavigationLink(destination:  AtheletsDetailView(viewModel: SquadListViewModel(atheleteObj: athleteObj, squadService: SquadsService(apiClient: APIClient())))
                .navigationTitle(athleteObj.formattedInfo().string),
                           isActive: $shouldNavigate) {
                EmptyView()
            }
            
            VStack(alignment: .leading) {
                HStack{
                    VStack(alignment: .leading, spacing: Padding.edgeSmall) {
                        AthletesInfoViews(athleteObj: athleteObj,
                                          maxWidth: preferredMaxLayoutWidth - Padding.edgeMax)
                      
                        .gesture(TapGesture().onEnded({
                            shouldNavigate = true
                        }))
                        
                        
                    }
                }
                .padding(Padding.edgeMax)
                .background(Color(UIColor.white))
            }
        }
    }
}


struct AthleteListItemView_Previews: PreviewProvider {
    
    static var previews: some View {

        AthleteListItemView(viewModel: getModel(), athleteObj: getAthelete(), preferredMaxLayoutWidth: 400)
    }
    
    static func getModel() -> AthleteListViewModel {
        let viewModel = AthleteListViewModel()
        viewModel.state = .loaded
     
        let athleteObj = AthleteListResultsSectionData(key: "My name", displayValue: "Athlete",
                                                       items: [getAthelete()])
        viewModel.sectionedList.append(athleteObj)
        return viewModel
    }
    
    static func getAthelete() -> AthleteListResultObject {
        let athlete = Athlete(firstName: "Kim", lastName: "Vaghasia", userName: "KimVag", athleteImage: AthleteImage(url: "https://kitman.imgix.net/avatar.jpg"))
        
        return AthleteListResultObject(athlete: athlete)

    }
}
