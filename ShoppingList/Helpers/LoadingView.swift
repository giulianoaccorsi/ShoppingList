//
//  LoadingView.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit
import Lottie

class LoadingView: UIView {
    private let loading: AnimationView = {
        let image = AnimationView(name: "loading-lottie")
        image.loopMode = .loop
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        self.backgroundColor = .black.withAlphaComponent(0.7)
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func load() {
        loading.play()
    }

    func stop() {
        loading.stop()
    }
}

extension LoadingView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(loading)
    }

    func setUpConstraints() {
        let ratio: CGFloat = 50/100

        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: ratio)

        ])
    }

    func setUpAdditionalConfiguration() {}

}
