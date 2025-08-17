//  ActivityIndicator.swift
//
//  Created by Kimti Vaghasia
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    var isAnimating: Bool
    typealias UIView = UIActivityIndicatorView
    var configuration = { (indicator: UIView) in }
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        self.isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}


extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView)->Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}
