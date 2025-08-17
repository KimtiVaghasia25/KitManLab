//  LoadingViews.swift
//
//  Created by Kimti Vaghasia
//

import SwiftUI

struct PageLoadingView : View {
    var body: some View {
    HStack(alignment: .center){
        ActivityIndicator(isAnimating: true)
        Text(AppMessage.loadingData)
            .foregroundColor(Color.gray)
            .font(.footnote)
        }
    .frame(maxWidth: .infinity, minHeight: AppSize.loadingHeight)
    }
}



struct ListLoadingView : View {

    var loadingImage: UIImage? = nil
    var loadingStatus: String? = nil
    var loadingDescription: String? = nil

    var body: some View {
        VStack(spacing: 8){
        if let loadingImage = loadingImage {
            Image(uiImage: loadingImage)
        }
        if let loadingStatus = loadingStatus {
            Text(loadingStatus)
                .font(Font(UIFont.boldSystemFont(ofSize: AppFontSize.title)))
              .foregroundColor(AppColor.descColor)
              .multilineTextAlignment(.center)
        }
        if let loadingDescription = loadingDescription {
            Text(loadingDescription)
                .font(Font(UIFont.systemFont(ofSize: AppFontSize.body)))
              .foregroundColor(AppColor.descColor)
              .multilineTextAlignment(.center)
              
            }
        }
        .padding([.trailing, .leading], Padding.edgeMed)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
