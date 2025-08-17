//
//  AthletesInfoViews.swift
//  
//
//  Created by Kimti Vaghasia
//

import SwiftUI

struct AthletesInfoViews: View {
    var athleteObj: AthleteListResultObject
    var maxWidth : CGFloat

    var body: some View {
        
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 5) {
                
                if let urlString = athleteObj.athlete.athleteImage?.url {
                    AthletesImageView(urlString: urlString)

                }
                
                AttributedText()
                {
                    $0.font = StyleManager.thinApplicationFont(size: AppFontSize.subtitle)
                    $0.textColor = AppColor.labelGrey
                    $0.numberOfLines = 0
                    $0.lineBreakMode = .byWordWrapping
                    $0.attributedText = athleteObj.formattedInfo()
                    $0.preferredMaxLayoutWidth = maxWidth
                }
                .frame(width: maxWidth)
                .padding( Padding.edgeSmall)
            }
            .padding(.leading, 30)

        }
    }
}

struct AthletesInfoViews_Previews: PreviewProvider {
    
    static var previews: some View {
        let athlete = Athlete(firstName: "Kim", lastName: "Vaghasia", userName: "KimVag", athleteImage: AthleteImage(url: "https://kitman.imgix.net/avatar.jpg"))

        AthletesInfoViews(athleteObj: AthleteListResultObject(athlete: athlete), maxWidth: 400)
    }
}
