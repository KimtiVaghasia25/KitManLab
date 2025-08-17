//  StyleManager.swift
//
//  Created by Kimti Vaghasia

import Foundation
import UIKit
import SwiftUICore

class StyleManager: NSObject {
    
    
    class func thinApplicationFont(size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .thin)
    }
    
    class func lightApplicationFont(size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)

    }
    
    class func mediumApplicationFont(size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    class func boldApplicationFont(size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    
    class var apiDateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }
}

struct AppFontSize {
    static let title: CGFloat = 17
    static let subtitle: CGFloat = 12
    static let body: CGFloat = 15
}

struct Padding {
    static let edgeMin: CGFloat = 2
    static let edgeSmall: CGFloat = 5
    static let edgeMed: CGFloat = 8
    static let edgeMax: CGFloat = 10

}

struct AppColor {
    static let descColor = Color(UIColor(red: 170/255.0, green: 171/255.0, blue: 179/255.0, alpha: 1.0))
    static let strokeColor = Color(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0)
    static let headerbackgroundColor = Color(UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1.0))
    static let labelGrey = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
}

struct AppMessage {
    
    static let noDataFound = "No Data Found"
    static let noInternetConnection = "No Internet Connection"
    static let loadingData = "Loading Data..."
    static let noDataAvailable = "No Data Available"
    static let noDataToDisplay = "No Data To Display"
    static let unknownError = "Something went wrong"
    static let welcomeText = "Welcome"
    static let refreshText = "Please tap here to refresh"
}

struct SystemImage {
    static let loading =  "person.line.dotted.person"
    static let chevronUp = "chevron.up"
    static let chevronDown = "chevron.down"
}

struct AppSize {
    static let headerHeight: CGFloat = 30
    static let footerHeight: CGFloat = 50
    static let loadingHeight: CGFloat = 55
    
    struct Margin {
        static let width: CGFloat = 40

    }
}
