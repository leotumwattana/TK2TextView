//
//  NSRange+Extensions.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 25/4/2022.
//

import Foundation

extension NSRange {
    static let notFound = NSRange(location: NSNotFound, length: 0)
    
    var isEmpty: Bool {
        length == 0
    }
}

extension NSRange {
    func extending(length by: Int) -> Self {
        NSRange(location: location, length: length + by)
    }
    
    func with(length: Int) -> Self {
        NSRange(location: location, length: length)
    }
    
    func offset(location by: Int) -> Self {
        NSRange(location: location + by, length: length)
    }
}
