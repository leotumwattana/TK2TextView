//
//  UIFont+Extensions.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 24/4/2022.
//

import UIKit

extension UIFont {
    var bold: UIFont {
        with(traits: .traitBold)
    }
    
    var italic: UIFont {
        with(traits: .traitItalic)
    }
    
    var boldItalic: UIFont {
        with(traits: [.traitBold, .traitItalic])
    }
    
    func monospaced(weight: Weight = .regular) -> UIFont {
        UIFont.monospacedSystemFont(ofSize: pointSize, weight: weight)
    }
    
    static var code: UIFont {
        UIFont.preferredFont(forTextStyle: .body).monospaced()
    }
}

extension UIFont {
    
    /**
     Easier way to specify font style, weight and italics.
     https://stackoverflow.com/questions/53356530/default-uifont-size-and-weight-but-also-support-preferredfontfortextstyle
     */
    
    static func preferredFont(for style: TextStyle, weight: Weight, italic: Bool = false) -> UIFont {
        
        // Get the style's default pointSize
        let traits = UITraitCollection(preferredContentSizeCategory: .large)
        let desc = UIFontDescriptor.preferredFontDescriptor(
            withTextStyle: style,
            compatibleWith: traits
        )
        
        // Get the font at the default size and preferred weight
        var font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        if italic == true {
            font = font.with(traits: [.traitItalic])
        }
        
        // Setup the font to be auto-scalable
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
    
    private func with(traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(
            fontDescriptor.symbolicTraits.union(
                UIFontDescriptor.SymbolicTraits(traits)
            )
//            UIFontDescriptor.SymbolicTraits(traits)
//                .union(fontDescriptor.symbolicTraits)
        ) else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }
    
}
