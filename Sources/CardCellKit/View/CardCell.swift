//
//  CollectionCard.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//

import SwiftUI
import UIKit


class CardCell: UICollectionViewCell {
    
    var title: String? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    var image: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    var isFavorite: Bool? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    override init(frame: CGRect) {
        self.image = nil
        self.title = nil
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }
    
    init(image: UIImage? = nil, titleText: String? = nil) {
        self.image = image
        self.title = titleText
        super.init(frame: .zero)
        self.layer.masksToBounds = true
    }
    
    init(contentConfiguration: CardCellContentConfiguration) {
        self.image = contentConfiguration.image
        self.title = contentConfiguration.title
        super.init(frame: .zero)
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        backgroundConfiguration = CardCellBackgroundConfiguration.configuration(for: state)
        
        var content = CardCellContentConfiguration().updated(for: state)
        
        content.image = image
        content.title = title
        contentConfiguration = content
    }
    
    func defaultContentConfiguration() -> CardCellContentConfiguration {
        return CardCellContentConfiguration()
    }
}

#Preview {
//    CardCell()
//        .representableView(size: .init(width: 150, height: 150))
    Text("a")
        .onAppear {
            #if DEBUG
            print("debug")
            #elseif RELEASE
            print("release")
            #endif
        }
}
