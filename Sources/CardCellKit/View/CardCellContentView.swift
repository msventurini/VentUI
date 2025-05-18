//
//  CardCellContentView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit

class CardCellContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? CardCellContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }

    private let imageView = UIImageView()

    private let labelView = UILabel()

    private let cropMask: UIView = {
        let cropMask = UIView()

        cropMask.backgroundColor = .black

        return cropMask
    }()

//    private let labelBackgroundView: UIView = {
//
//        let backgroundView = UIView()
//
//        backgroundView.backgroundColor = .gray
//
//        return backgroundView
//    }()
    
    private let labelBackgroundView: UIVisualEffectView = {

        let visualEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        
        let backgroundView = UIVisualEffectView(effect: visualEffect)



        return backgroundView
    }()

    init(configuration: CardCellContentConfiguration) {
        super.init(frame: .zero)
        setupInternalViews()
        apply(configuration: configuration)
    }

    private var appliedConfiguration: CardCellContentConfiguration!

    private func apply(configuration: CardCellContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration
        labelView.text = configuration.title
        
        guard let newImage = configuration.image else {
            imageView.backgroundColor = .quaternarySystemFill
            return
        }
        
        imageView.backgroundColor = .clear
        
        imageView.image = newImage
        
        imageView.contentMode = .scaleAspectFill

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardCellContentView {
    private func setupInternalViews() {

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(labelBackgroundView)

        labelBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            labelBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            labelBackgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),

            labelView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelView.centerYAnchor.constraint(equalTo: labelBackgroundView.centerYAnchor),

            labelView.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),

            labelView.topAnchor.constraint(greaterThanOrEqualTo: labelBackgroundView.topAnchor),
        ])
    }
}

#Preview {
    DebugView()
}
