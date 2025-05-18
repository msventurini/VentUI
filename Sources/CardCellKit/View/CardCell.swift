//
//  CollectionCard.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//

import SwiftUI
import UIKit

class CardCell: UICollectionViewCell {

    var image: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    var titleText: String? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    override init(frame: CGRect) {
        self.image = nil
        self.titleText = nil
        super.init(frame: .zero)
        self.layer.masksToBounds = true
    }
    
    init(image: UIImage? = nil, titleText: String? = nil) {
        self.image = image
        self.titleText = titleText
        super.init(frame: .zero)
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        backgroundConfiguration = CardCellBackgroundConfiguration.configuration(for: state)
        
        var content = CardCellContentConfiguration().updated(for: state)
        
        content.image = image
        content.titleText = titleText
        contentConfiguration = content
    }
}

#Preview {
    DebugView()
}
