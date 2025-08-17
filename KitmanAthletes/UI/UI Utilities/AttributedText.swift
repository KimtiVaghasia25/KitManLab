//  AttributedText.swift
//
//  Created by Kimti Vaghasia 
//

import SwiftUI

struct AttributedText: UIViewRepresentable {

    typealias TheUIView = UILabel
    var configuration = { (view: TheUIView) in }

    func makeUIView(context: Context) -> TheUIView {
        TheUIView()
    }
    func updateUIView(_ uiView: TheUIView, context: Context) {
        configuration(uiView)
    }
}

extension View where Self == AttributedText {
    func configure(_ configuration: @escaping (Self.TheUIView)->Void) -> Self {
        Self.init(configuration: configuration)
    }
}
