//
//  SortedTextRange.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 30/4/2022.
//

import UIKit

final class SortedTextRange: UITextRange {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    let startPosition: SortedTextPosition
    let endPosition: SortedTextPosition
    
    override var isEmpty: Bool {
        startPosition.index >= endPosition.index
    }
    
    override var description: String {
        "[\(startPosition.index) ..< \(endPosition.index)]"
    }
    
    var length: Int {
        endPosition.index - startPosition.index
    }
    
    // ============
    // MARK: - Init
    // ============
    
    init(from: SortedTextPosition, to: SortedTextPosition) {
        let start: SortedTextPosition
        let end: SortedTextPosition
        
        // Ensure startPosition is less than endPosition
        if from.index < to.index {
            start = from
            end = to
        } else {
            start = to
            end = from
        }
        startPosition = start
        endPosition = end
    }
    
    init(from: SortedTextPosition, maxIndex: Int, in str: String) {
        if maxIndex >= 0 {
            startPosition = from
            let end = min(str.count, from.index + maxIndex)
            endPosition = SortedTextPosition(index: end)
        } else {
            endPosition = from
            let start = max(0, from.index + maxIndex)
            startPosition = SortedTextPosition(index: start)
        }
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    func range(in str: String) -> Range<String.Index> {
        let startIndex = str.index(
            str.startIndex,
            offsetBy: startPosition.index
        )
        let endIndex = str.index(
            startIndex,
            offsetBy: endPosition.index - startPosition.index
        )
        return startIndex..<endIndex
    }
    
    func nsRange(in str: String) -> NSRange {
        return NSRange(range(in: str), in: str)
    }
}
