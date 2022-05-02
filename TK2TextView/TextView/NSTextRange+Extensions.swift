//
//  NSTextRange+Extensions.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 25/4/2022.
//

import UIKit

extension NSTextRange {
    
    convenience init?(
        _ nsRange: NSRange,
        in textContentManager: NSTextContentManager
    ) {
        guard let start = textContentManager.location(
            textContentManager.documentRange.location,
            offsetBy: nsRange.location
        ) else { return nil }
        
        let end = textContentManager
            .location(start, offsetBy: nsRange.length)
        self.init(location: start, end: end)
    }
}
