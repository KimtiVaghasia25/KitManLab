//
//  AthletesImageView.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//
import SwiftUI

struct AthletesImageView: View {
    var urlString: String

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
                switch phase {
                   case .failure:
                       Image(systemName: "photo")
                           .font(.largeTitle)
                   case .success(let image):
                       image
                           .resizable()
                   default:
                       ProgressView()
                   }
               }
               .frame(width: 100, height: 100)
               .clipShape(.rect(cornerRadius: 25))
    }
}



struct AthletesImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        AthletesImageView(urlString: "https://kitman.imgix.net/avatar.jpg")
    }
}
