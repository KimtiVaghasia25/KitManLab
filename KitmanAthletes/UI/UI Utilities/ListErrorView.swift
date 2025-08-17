//  ListErrorView.swift
//
//  Created by Kimti Vaghasia.
//
import SwiftUI

struct ListErrorView: View {
    let error: Error

    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text(error.localizedDescription)
                .font(.callout)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 25).padding()
            Button(action: retryAction, label: { Text(AppMessage.refreshText).bold() })
        }.padding([.trailing, .leading], Padding.edgeMin)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ListErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ListErrorView(error: NSError(domain: "", code: 0, userInfo: [
            NSLocalizedDescriptionKey: AppMessage.unknownError]),
                  retryAction: { })
    }
}
