//
//  NSAttributedString+Extensions.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 24/4/2022.
//

import UIKit

extension NSAttributedString {
    func font(at location: Int) -> UIFont? {
        attribute(.font, at: location, effectiveRange: nil) as? UIFont
    }
}

extension NSAttributedString {
    
    /**
     Returns an NSAttributedString with an SFSymbol link image as an image
     attachment.
     */
    static var linkSymbol: NSAttributedString {
        let attachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(
            font: .preferredFont(forTextStyle: .subheadline)
        )
        attachment.image = UIImage(systemName: "link")?
            .withConfiguration(config)
            .withTintColor(.systemGray3, renderingMode: .alwaysTemplate)
        return NSAttributedString(attachment: attachment)
    }
}

extension NSMutableAttributedString {
    func addAttributes(
        _ attributes: [NSAttributedString.Key: AnyObject],
        to ranges: [NSRange]
    ) {
        ranges.forEach { addAttributes(attributes, range: $0) }
    }
}
