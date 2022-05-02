//
//  NSAttributedStringKey+Extensions.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 27/4/2022.
//

import Foundation

extension NSAttributedString.Key {
    
    static let checklistItem = NSAttributedString
        .Key(rawValue: "com.staysorted.checklistItem")
    
    static let codeBlock = NSAttributedString
        .Key(rawValue: "com.staysorted.codeBlock")
    
}

enum CodeBlockSegmentType {
    case leading
    case content
    case trailing
}
