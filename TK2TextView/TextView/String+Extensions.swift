//
//  String+Extensions.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 24/4/2022.
//

import Foundation

extension String {
    
    /**
     Cast String to NSString
     */
    @inlinable
    @inline(__always)
    var nsString: NSString {
        self as NSString
    }
    
    /**
     Return the NSRange representing the String
     */
    @inlinable
    @inline(__always)
    var fullNSRange: NSRange {
        nsString.fullNSRange
    }
    
}

extension String {
    /**
     Returns a run of length count of zero width spaces.
     */
    static func zeroWidthSpaces(count: Int) -> String {
        String(repeating: .zeroWidthSpace, count: count)
    }
}

extension NSString {
    
    /**
     Cast NSString to String
     */
    @inlinable
    @inline(__always)
    var string: String {
        self as String
    }
    
    
    /**
     Return the NSRange representing the NSString
     */
    @inlinable
    @inline(__always)
    var fullNSRange: NSRange {
        NSRange(location: 0, length: length)
    }
    
}

extension String {
    
    static var zeroWidthSpace: String {
        String("\u{200B}")
    }
}
